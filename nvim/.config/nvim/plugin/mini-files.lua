require("mini.files").setup({
    mappings = {
        synchronize = "w",
        go_in_plus = "<CR>",
    },
})

local show_dotfiles = true

local filter_show = function(fs_entry)
    return true
end

local filter_hide = function(fs_entry)
    return not vim.startswith(fs_entry.name, ".")
end

local toggle_dotfiles = function()
    show_dotfiles = not show_dotfiles
    local new_filter = show_dotfiles and filter_show or filter_hide
    require("mini.files").refresh({ content = { filter = new_filter } })
end

vim.api.nvim_create_autocmd("User", {
    pattern = "MiniFilesBufferCreate",
    callback = function(args)
        local buf_id = args.data.buf_id
        vim.keymap.set("n", "g.", toggle_dotfiles, { buffer = buf_id })
        vim.keymap.set("n", "-", require("mini.files").close, { buffer = buf_id })
    end,
})

vim.keymap.set("n", "<leader>be", function()
    require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
end)

vim.keymap.set("n", "<leader>e", function()
    local mf = require("mini.files")
    if mf.open then
        mf.open()
    else
        vim.cmd.Ex()
    end
end)
