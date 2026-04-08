return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local harpoon = require("harpoon")
		local harpoon_extensions = require("harpoon.extensions")

		-- REQUIRED
		harpoon:setup({
			settings = {
				save_on_toggle = true,
				sync_on_ui_close = true,
				key = function()
					return vim.uv.cwd()
				end,
			},
		})
		-- REQUIRED

		harpoon:extend(harpoon_extensions.builtins.highlight_current_file())

		local map = vim.keymap.set
		map("n", "<leader>a", function()
			harpoon:list():add()
		end)
		map("n", "<C-e>", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end)
		map("n", "<leader>1", function()
			harpoon:list():select(1)
		end)
		map("n", "<leader>2", function()
			harpoon:list():select(2)
		end)
		map("n", "<leader>3", function()
			harpoon:list():select(3)
		end)
		map("n", "<leader>4", function()
			harpoon:list():select(4)
		end)
		map("n", "<C-S-P>", function()
			harpoon:list():prev()
		end)
		map("n", "<C-S-N>", function()
			harpoon:list():next()
		end)
	end,
}
