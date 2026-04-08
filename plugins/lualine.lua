return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local lualine = require("lualine")

		local conditions = {
			buffer_not_empty = function()
				return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
			end,
			hide_in_width = function()
				return vim.fn.winwidth(0) > 80
			end,
			check_git_workspace = function()
				local filepath = vim.fn.expand("%:p:h")
				local gitdir = vim.fn.finddir(".git", filepath .. ";")
				return gitdir and #gitdir > 0 and #gitdir < #filepath
			end,
		}

		local config = {
			options = {
				component_separators = "",
				section_separators = "",
				theme = "everforest",
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

		local ef = {
			blue = "#7fbbb3",
			magenta = "#d699b6",
			orange = "#e69875",
			green = "#a7c080",
			red = "#e67e80",
			yellow = "#dbbc7f",
			cyan = "#83c092",
		}
		ins_left({
			function()
				local mode_icons = {
					n = "󰩨",
					v = "󰒅",
					V = "󰫙",
					s = "", -- Select character
					["\22"] = "󰩬", -- Visual block
					S = "", -- Select line
					["\19"] = "", -- Select block
					i = "󰏫",
					R = "󰛔", -- Replace, Replace completion, Virtual Replace, etc.
					c = "", -- Command-line, Overstrike, Ex mode
					r = "󰌑", -- Hit-enter, --more--, :confirm prompts
					["!"] = "",
					t = "", -- Terminal mode
				}
				return mode_icons[vim.fn.mode()] or ""
			end,

			color = function()
				local mode_color = {
					n = ef.blue, -- Normal (calm)
					v = ef.magenta, -- Visual (highlight)
					V = ef.magenta, -- Visual line
					["\22"] = ef.magenta, -- Visual block
					s = ef.orange, -- Select
					S = ef.orange, -- Select line
					["\19"] = ef.orange, -- Select block
					i = ef.green, -- Insert (active)
					R = ef.red, -- Replace (danger)
					c = ef.yellow, -- Command (attention)
					r = ef.cyan, -- Prompts (info)
					["!"] = ef.red, -- Shell (executing)
					t = ef.green, -- Terminal (active)
				}
				return { fg = mode_color[vim.fn.mode()] or ef.blue }
			end,
			padding = { left = 1, right = 1 },
		})

		ins_left({
			"filesize",
			cond = conditions.buffer_not_empty,
		})

		ins_left({
			"filename",
			cond = conditions.buffer_not_empty,
		})

		ins_left({ "location" })

		ins_left({ "progress" })

		ins_left({
			"diagnostics",
			sources = { "nvim_diagnostic" },
			symbols = { error = " ", warn = " ", info = " " },
		})

		ins_left({
			function()
				return "%="
			end,
		})

		ins_left({
			function()
				local msg = "No Active Lsp"
				local buf_ft = vim.api.nvim_get_option_value("filetype", { buf = 0 })
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
			icon = " LSP:",
		})

		ins_right({
			"o:encoding",
			fmt = string.upper,
			cond = conditions.hide_in_width,
		})

		ins_right({
			"fileformat",
			fmt = string.upper,
			icons_enabled = false,
		})

		ins_right({
			"branch",
			icon = "",
		})

		ins_right({
			"diff",
			symbols = { added = " ", modified = " ", removed = " " },
			cond = conditions.hide_in_width,
		})

		ins_right({
			function()
				return ""
			end,
			padding = { left = 1 },
		})

		lualine.setup(config)
	end,
}
