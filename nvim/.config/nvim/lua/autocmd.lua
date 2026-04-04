local lsp = vim.lsp.buf

vim.api.nvim_create_autocmd("LspAttach", {
	desc = "LSP actions",
	callback = function(event)
		local opts = { buffer = event.buf }
		vim.keymap.set("n", "K", lsp.hover, opts)
		vim.keymap.set("n", "gd", lsp.definition, opts)
		vim.keymap.set("n", "gD", lsp.declaration, opts)
		vim.keymap.set("n", "gi", lsp.implementation, opts)
		vim.keymap.set("n", "gr", lsp.references, opts)
		vim.keymap.set("n", "go", lsp.type_definition, opts)
		vim.keymap.set("n", "<leader>rn", lsp.rename, opts)
		vim.keymap.set("n", "<leader>ca", lsp.code_action, opts)
	end,
})

local cpp_compiler = "clang++"
local cpp_flags = "-std=c++20 -O2 -Wall -Wextra"
local compiled_outputs = {}
local cpp_build_group = vim.api.nvim_create_augroup("CppBuildRun", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
	pattern = "cpp",
	group = cpp_build_group,
	callback = function()
		vim.opt_local.errorformat = "%f:%l:%c: %t%*[^:]: %m,%f:%l: %t%*[^:]: %m"

		local function run_executable(out)
			if not (vim.env.TMUX and vim.env.TMUX ~= "") then
				return
			end
			local cmd = string.format(
				'./%s; code=$?; echo; echo "Process exited with code $code"; read -n1 -s -p "Press any key to close..."',
				out
			)
			vim.system({ "tmux", "new-window", "-n", out, "bash", "-lc", cmd }, { detach = true })
		end

		local function build(should_run)
			vim.cmd("silent write")

			local out = "program"
			local cpp_files = vim.fn.glob("*.cpp", false, true)

			if #cpp_files == 0 then
				vim.notify("No .cpp files found", vim.log.levels.WARN)
				return
			end

			compiled_outputs[out] = true

			local args = vim.split(cpp_compiler .. " " .. cpp_flags, "%s+")
			vim.list_extend(args, cpp_files)
			vim.list_extend(args, { "-o", out })

			vim.fn.setqflist({}, "r", { title = "C++ Build", items = {} })
			vim.notify("Building " .. #cpp_files .. " file(s)...", vim.log.levels.INFO)

			vim.system(args, { text = true }, function(obj)
				vim.schedule(function()
					if obj.code ~= 0 then
						local lines = vim.split((obj.stdout or "") .. (obj.stderr or ""), "\n", { trimempty = true })
						vim.fn.setqflist({}, "r", { title = cpp_compiler .. " build", lines = lines })
						vim.cmd("copen")
						vim.notify(string.format("Build failed (exit %d)", obj.code), vim.log.levels.ERROR)
					else
						vim.cmd("cclose")
						vim.notify(
							should_run and "Build successful - running..." or "Build successful: " .. out,
							vim.log.levels.INFO
						)
						if should_run then
							run_executable(out)
						end
					end
				end)
			end)
		end

		vim.keymap.set("n", "<F5>", function()
			build(true)
		end, { buffer = true, silent = true, desc = "Build and run C++" })
		vim.keymap.set("n", "<F6>", function()
			build(false)
		end, { buffer = true, silent = true, desc = "Build C++ only" })
	end,
})

vim.api.nvim_create_autocmd("VimLeavePre", {
	group = cpp_build_group,
	callback = function()
		for out, _ in pairs(compiled_outputs) do
			os.remove(out)
		end
	end,
})
