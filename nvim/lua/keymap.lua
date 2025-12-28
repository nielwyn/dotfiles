local harpoon = package.loaded.harpoon
local gitsigns = package.loaded.gitsigns
local mini_files = package.loaded['mini.files']
local conform = package.loaded.conform

-- Create a smart keymap wrapper using metatables
local keymap = {}

-- Valid vim modes
local valid_modes =
{ n = true, i = true, v = true, x = true, s = true, o = true, c = true, t = true }

-- Store mode combinations we've created
local mode_cache = {}

local function perform_mapping(modes, lhs, rhs, opts)
  opts = opts or {}
  local mapset = vim.keymap.set

  if type(lhs) == 'table' then
    -- Handle table of mappings
    for key, action in pairs(lhs) do
      mapset(modes, key, action, opts)
    end
  else
    -- Handle single mapping
    mapset(modes, lhs, rhs, opts)
  end

  return keymap -- Return keymap for chaining
end

-- Parse a mode string into an array of mode characters
local function parse_modes(mode_str)
  local modes = {}
  for i = 1, #mode_str do
    local char = mode_str:sub(i, i)
    if valid_modes[char] then
      table.insert(modes, char)
    end
  end
  return modes
end

-- Create the metatable that powers the dynamic mode access
local mt = {
  __index = function(_, key)
    -- If this mode combination is already cached, return it
    if mode_cache[key] then
      return mode_cache[key]
    end

    -- Check if this is a valid mode string
    local modes = parse_modes(key)
    if #modes > 0 then
      -- Create and cache a function for this mode combination
      local mode_fn = function(lhs, rhs, opts)
        return perform_mapping(modes, lhs, rhs, opts)
      end

      mode_cache[key] = mode_fn
      return mode_fn
    end

    return nil -- Not a valid mode key
  end,

  -- Make the keymap table directly callable
  __call = function(_, modes, lhs, rhs, opts)
    return perform_mapping(type(modes) == 'string' and parse_modes(modes) or modes, lhs, rhs, opts)
  end,
}

local map = setmetatable(keymap, mt)

-- Helper function for command mappings
local cmd = function(command)
  return '<cmd>' .. command .. '<CR>'
end

------------------------------------------------------------------------
-- CORE MAPPINGS
------------------------------------------------------------------------

map.nv {
  ['y'] = '"+y',
  ['x'] = '"_x', -- Delete without yanking
}

map.n {
  ['Y'] = '"+Y',
}

map.v {
  ['<C-j>'] = ":m '>+1<CR>gv",
  ['<C-k>'] = ":m '<-2<CR>gv",
}

-- Copy buffer path to clipboard
map.n('yp', function()
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("+", path)
  vim.notify('Copied "' .. path .. '" to the clipboard!')
end)

-- Conform formatting
map.nv("<leader>bf", function()
  if conform then
    conform.format({ async = true }, function(err)
      if not err then
        local mode = vim.api.nvim_get_mode().mode
        if vim.startswith(string.lower(mode), "v") then
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
        end
      end
    end)
  else
    vim.lsp.buf.format({ async = false })
  end
end)

------------------------------------------------------------------------
-- PLUGIN MAPPINGS
------------------------------------------------------------------------

----------------------------
-- FzfLua
----------------------------
map.n {
  ['<Leader>fr'] = cmd('FzfLua resume'),
  ['<Leader>fc'] = cmd('FzfLua lgrep_curbuf'),
  ['<Leader>fb'] = cmd('FzfLua buffers'),
  ['<Leader>fa'] = cmd('FzfLua live_grep_native'),
  -- ['<Leader>fs'] = cmd('FzfLua grep_cword'),
  ['<Leader>ff'] = cmd('FzfLua files'),
  ['<Leader>fh'] = cmd('FzfLua helptags'),
  ['<Leader>fo'] = cmd('FzfLua oldfiles'),
  ['<Leader>fs'] = cmd('FzfLua git_status'),
  ['<Leader>o'] = cmd('FzfLua lsp_document_symbols'),
}

----------------------------
-- UndoTree
----------------------------
map.n {
  ['<Leader>u'] = cmd('UndotreeToggle'),
}

----------------------------
-- Harpoon
----------------------------
map.n {
  ['<leader>a'] = function() harpoon:list():add() end,
  ['<C-e>'] = function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
  ['<leader>1'] = function() harpoon:list():select(1) end,
  ['<leader>2'] = function() harpoon:list():select(2) end,
  ['<leader>3'] = function() harpoon:list():select(3) end,
  ['<leader>4'] = function() harpoon:list():select(4) end,
  ['<C-S-P>'] = function() harpoon:list():prev() end,
  ['<C-S-N>'] = function() harpoon:list():next() end,
}

----------------------------
-- mini.files
----------------------------
map.n {
  ['<leader>be'] = function() mini_files.open(vim.api.nvim_buf_get_name(0), true) end,
}
-- Open file explorer or fallback to netrw
map.n('<leader>e', function()
  if mini_files.open then
    mini_files.open()
  else
    vim.cmd.Ex()
  end
end)

----------------------------
-- gitsigns
----------------------------
map.n({
  [']c'] = function()
    if vim.wo.diff then return ']c' end
    vim.schedule(function() gitsigns.nav_hunk('next') end)
    return '<Ignore>'
  end,
  ['[c'] = function()
    if vim.wo.diff then return '[c' end
    vim.schedule(function() gitsigns.nav_hunk('prev') end)
    return '<Ignore>'
  end,
  ['<leader>hr'] = gitsigns.reset_hunk,
  ['<leader>hp'] = gitsigns.preview_hunk,
}, { expr = true })

map.v({
  ['<leader>hr'] = function()
    gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
  end,
})
