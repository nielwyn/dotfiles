-- Minimal pinned-files list, persisted per project.

local data_file = vim.fn.stdpath("data") .. "/pins.json"
local current_idx = {} -- cwd -> last selected index, in-memory only
local ns = vim.api.nvim_create_namespace("pins")

vim.api.nvim_set_hl(0, "PinsCurrentFile", { link = "Visual" })

local function read_data()
    local f = io.open(data_file, "r")
    if not f then
        return {}
    end
    local content = f:read("*a")
    f:close()
    local ok, data = pcall(vim.json.decode, content)
    if not ok or type(data) ~= "table" then
        return {}
    end
    return data
end

local function write_data(data)
    local f = io.open(data_file, "w")
    if not f then
        return
    end
    f:write(vim.json.encode(data))
    f:close()
end

local function get_list()
    local data = read_data()
    return data[vim.fn.getcwd()] or {}
end

local function set_list(list)
    local data = read_data()
    data[vim.fn.getcwd()] = list
    write_data(data)
end

local M = {}

function M.add()
    local path = vim.fn.expand("%:p")
    if path == "" then
        return
    end
    local list = get_list()
    for _, item in ipairs(list) do
        if item == path then
            vim.notify("Pins: already pinned " .. vim.fn.fnamemodify(path, ":."))
            return
        end
    end
    table.insert(list, path)
    set_list(list)
    vim.notify("Pins: added " .. vim.fn.fnamemodify(path, ":."))
end

function M.select(idx)
    local list = get_list()
    local path = list[idx]
    if not path then
        vim.notify("Pins: no pin " .. idx, vim.log.levels.WARN)
        return
    end
    current_idx[vim.fn.getcwd()] = idx
    if path ~= vim.fn.expand("%:p") then
        vim.cmd.edit(vim.fn.fnameescape(path))
    end
end

function M.cycle(direction)
    local list = get_list()
    if #list == 0 then
        return
    end
    local cwd = vim.fn.getcwd()
    local idx = current_idx[cwd] or 0
    idx = ((idx - 1 + direction) % #list) + 1
    M.select(idx)
end

-- Opens an editable scratch buffer listing pins, one path per line.
-- Edit it like a normal buffer: dd to unpin, p/:m to reorder, type a
-- path on a blank line to pin it. Changes are saved when the window
-- closes; <CR> saves and jumps to the file under the cursor.
function M.toggle_quick_menu()
    local cwd = vim.fn.getcwd()
    local list = get_list()
    local current_file = vim.fn.expand("%:p")

    local lines = {}
    for _, path in ipairs(list) do
        table.insert(lines, vim.fn.fnamemodify(path, ":."))
    end
    if #lines == 0 then
        lines = { "" }
    end

    local width = 40
    for _, line in ipairs(lines) do
        width = math.max(width, #line + 4)
    end
    width = math.min(width, vim.o.columns - 4)
    local height = math.min(#lines, vim.o.lines - 4)

    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    vim.bo[buf].bufhidden = "wipe"
    vim.bo[buf].filetype = "pins"
    vim.b[buf].minicursorword_disable = true

    -- line numbers and the current-file highlight are drawn as extmarks
    -- so they stay anchored to position/content, not the raw text
    local function refresh()
        vim.api.nvim_buf_clear_namespace(buf, ns, 0, -1)
        for i, line in ipairs(vim.api.nvim_buf_get_lines(buf, 0, -1, false)) do
            local extmark = {
                virt_text = { { string.format("%d: ", i), "Comment" } },
                virt_text_pos = "inline",
            }
            local path = vim.trim(line)
            if path ~= "" and vim.fn.fnamemodify(path, ":p") == current_file then
                extmark.line_hl_group = "PinsCurrentFile"
            end
            vim.api.nvim_buf_set_extmark(buf, ns, i - 1, 0, extmark)
        end
    end
    refresh()
    vim.api.nvim_buf_attach(buf, false, { on_lines = refresh })

    local win = vim.api.nvim_open_win(buf, true, {
        relative = "editor",
        width = width,
        height = height,
        row = math.floor((vim.o.lines - height) / 2),
        col = math.floor((vim.o.columns - width) / 2),
        style = "minimal",
        border = "rounded",
        title = " Pins ",
        title_pos = "center",
    })

    local function sync()
        if not vim.api.nvim_buf_is_valid(buf) then
            return
        end
        local new_list = {}
        for _, line in ipairs(vim.api.nvim_buf_get_lines(buf, 0, -1, false)) do
            line = vim.trim(line)
            if line ~= "" then
                table.insert(new_list, vim.fn.fnamemodify(line, ":p"))
            end
        end
        local data = read_data()
        data[cwd] = new_list
        write_data(data)
    end

    local closed = false
    local function close()
        if closed then
            return
        end
        closed = true
        sync()
        if vim.api.nvim_win_is_valid(win) then
            vim.api.nvim_win_close(win, true)
        end
    end

    local opts = { buffer = buf, nowait = true }
    vim.keymap.set("n", "<CR>", function()
        local path = vim.trim(vim.api.nvim_get_current_line())
        close()
        if path ~= "" then
            path = vim.fn.fnamemodify(path, ":p")
            if path ~= vim.fn.expand("%:p") then
                vim.cmd.edit(vim.fn.fnameescape(path))
            end
        end
    end, opts)
    vim.keymap.set("n", "q", close, opts)
    vim.keymap.set("n", "<Esc>", close, opts)
    vim.keymap.set("n", "<C-e>", close, opts)

    -- close the box before jumping/cycling so these don't act on the
    -- floating window itself and leave it stuck open
    for i = 1, 4 do
        vim.keymap.set("n", "<leader>" .. i, function()
            close()
            M.select(i)
        end, opts)
    end
    vim.keymap.set("n", "<C-S-P>", function()
        close()
        M.cycle(-1)
    end, opts)
    vim.keymap.set("n", "<C-S-N>", function()
        close()
        M.cycle(1)
    end, opts)

    vim.api.nvim_create_autocmd("WinLeave", {
        buffer = buf,
        once = true,
        callback = close,
    })
end

local map = vim.keymap.set
map("n", "<leader>a", M.add)
map("n", "<C-e>", M.toggle_quick_menu)
map("n", "<leader>1", function() M.select(1) end)
map("n", "<leader>2", function() M.select(2) end)
map("n", "<leader>3", function() M.select(3) end)
map("n", "<leader>4", function() M.select(4) end)
map("n", "<C-S-P>", function() M.cycle(-1) end)
map("n", "<C-S-N>", function() M.cycle(1) end)
