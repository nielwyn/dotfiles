-- vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, { pattern = "*", command = "redrawstatus" })

local cpp_build_group = vim.api.nvim_create_augroup("CppBuildRun", { clear = true })

vim.g.cpp_compiler = vim.g.cpp_compiler or "clang++"
vim.g.cpp_flags = vim.g.cpp_flags or "-std=c++20 -O2 -Wall -Wextra"
vim.g.cpp_cleanup_on_exit = vim.g.cpp_cleanup_on_exit ~= false

-- Track compiled outputs for cleanup
local compiled_outputs = {}

vim.api.nvim_create_autocmd("FileType", {
  pattern = "cpp",
  group = cpp_build_group,
  callback = function()
    vim.opt_local.errorformat = "%f:%l:%c:  %t%*[^:]:  %m,%f:%l:  %t%*[^: ]: %m"

    local function run_executable(out)
      local run_cmd = vim.fn.shellescape("./" .. out)
      local full_cmd = string.format(
        '%s; exit_code=$? ; echo; echo "Process exited with code $exit_code"; read -n1 -s -p "Press any key to close..."',
        run_cmd
      )

      if vim.env.TMUX and vim.env.TMUX ~= "" then
        vim.system({
          "tmux", "new-window", "-n", out, "bash", "-lc", full_cmd
        }, { detach = true })
      end
    end

    local function build(should_run)
      vim.cmd("silent write")

      local out = "program"
      if out == "" then out = "cpp_run" end

      compiled_outputs[out] = true

      local cpp_files = vim.fn.glob("*.cpp", false, true)

      if #cpp_files == 0 then
        vim.notify("No .cpp files found in current directory", vim.log.levels.WARN)
        return
      end

      local compile_args = {}
      vim.list_extend(compile_args, vim.split(vim.g.cpp_compiler, "%s+"))
      vim.list_extend(compile_args, vim.split(vim.g.cpp_flags, "%s+"))

      for _, cpp_file in ipairs(cpp_files) do
        table.insert(compile_args, cpp_file)
      end

      table.insert(compile_args, "-o")
      table.insert(compile_args, out)

      vim.fn.setqflist({}, 'r', { title = 'C++ Build', items = {} })
      vim.notify("Building " .. #cpp_files .. " file(s)...", vim.log.levels.INFO)

      vim.system(
        compile_args,
        { text = true },
        function(obj)
          vim.schedule(function()
            if obj.code ~= 0 then
              -- Combine stdout and stderr for errors
              local output = (obj.stdout or "") .. (obj.stderr or "")
              local error_lines = vim.split(output, "\n", { trimempty = true })

              vim.fn.setqflist({}, 'r', {
                title = vim.g.cpp_compiler .. ' build',
                lines = error_lines,
              })
              vim.cmd("copen")
              vim.notify(
                string.format("Build failed (exit %d)", obj.code),
                vim.log.levels.ERROR
              )
            else
              vim.cmd("cclose")
              local success_msg = should_run
                  and "Build successful - running..."
                  or "Build successful:  " .. out
              vim.notify(success_msg, vim.log.levels.INFO)

              if should_run then
                run_executable(out)
              end
            end
          end)
        end
      )
    end

    local function build_and_run() build(true) end
    local function build_only() build(false) end
    vim.keymap.set("n", "<F5>", build_and_run, {
      buffer = true,
      silent = true,
      desc = "Build and run C++"
    })
    vim.keymap.set("n", "<F6>", build_only, {
      buffer = true,
      silent = true,
      desc = "Build C++ only"
    })
  end,
})

-- Cleanup on exit
vim.api.nvim_create_autocmd("VimLeavePre", {
  group = cpp_build_group,
  callback = function()
    if vim.g.cpp_cleanup_on_exit then
      for out_path, _ in pairs(compiled_outputs) do
        os.remove(out_path)
      end
    end
  end,
})
