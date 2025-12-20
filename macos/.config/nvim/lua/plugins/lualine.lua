return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local lualine = require('lualine')

    local conditions = {
      buffer_not_empty = function()
        return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
      end,
      hide_in_width = function()
        return vim.fn.winwidth(0) > 80
      end,
      check_git_workspace = function()
        local filepath = vim.fn.expand('%:p:h')
        local gitdir = vim.fn.finddir('.git', filepath .. ';')
        return gitdir and #gitdir > 0 and #gitdir < #filepath
      end,
    }

    local config = {
      options = {
        component_separators = '',
        section_separators = '',
        theme = "tokyonight-night",
      },
      sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        lualine_c = {},
        lualine_x = {},
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        lualine_c = {},
        lualine_x = {},
      },
    }

    local function ins_left(component)
      table.insert(config.sections.lualine_c, component)
    end

    local function ins_right(component)
      table.insert(config.sections.lualine_x, component)
    end

    ins_left {
      function() return '' end,
      color = function()
        -- Use tokyonight palette for mode color
        local tn = require("tokyonight.colors").setup()
        local mode_color = {
          n = tn.red,
          i = tn.green,
          v = tn.blue,
          [''] = tn.blue,
          V = tn.blue,
          c = tn.magenta,
          no = tn.red,
          s = tn.yellow,
          S = tn.yellow,
          [''] = tn.yellow,
          ic = tn.yellow,
          R = tn.orange,
          Rv = tn.orange,
          cv = tn.red,
          ce = tn.red,
          r = tn.cyan,
          rm = tn.cyan,
          ['r?'] = tn.cyan,
          ['!'] = tn.red,
          t = tn.red,
        }
        return { fg = mode_color[vim.fn.mode()] }
      end,
      padding = { left = 1, right = 1 },
    }

    ins_left {
      'filesize',
      cond = conditions.buffer_not_empty,
    }

    ins_left {
      'filename',
      cond = conditions.buffer_not_empty,
    }

    ins_left { 'location' }

    ins_left { 'progress' }

    ins_left {
      'diagnostics',
      sources = { 'nvim_diagnostic' },
      symbols = { error = ' ', warn = ' ', info = ' ' },
    }

    ins_left {
      function() return '%=' end,
    }

    ins_left {
      function()
        local msg = 'No Active Lsp'
        local buf_ft = vim.api.nvim_get_option_value('filetype', { buf = 0 })
        local clients = vim.lsp.get_clients()
        if next(clients) == nil then
          return msg
        end
        for _, client in ipairs(clients) do
          local filetypes = client.config.filetypes
          if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
            return client.name
          end
        end
        return msg
      end,
      icon = ' LSP:',
    }

    ins_right {
      'o:encoding',
      fmt = string.upper,
      cond = conditions.hide_in_width,
    }

    ins_right {
      'fileformat',
      fmt = string.upper,
      icons_enabled = false,
    }

    ins_right {
      'branch',
      icon = '',
    }

    ins_right {
      'diff',
      symbols = { added = ' ', modified = ' ', removed = ' ' },
      cond = conditions.hide_in_width,
    }

    ins_right {
      function() return '' end,
      padding = { left = 1 },
    }

    lualine.setup(config)
  end,
}
