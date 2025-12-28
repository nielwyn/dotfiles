-- vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, { pattern = "*", command = "redrawstatus" })

vim.api.nvim_create_autocmd("FileType", {
  pattern = "cpp",
  callback = function()
    -- Build+run function (buffer-local)
    local function build_and_run()
      vim.cmd("write")

      local file = vim.fn.expand("%")
      local out = vim.fn.expand("%:r") -- filename without extension
      if out == "" then out = "cpp_run" end

      local compile_cmd = string.format(
        "clang++ %s -std=c++20 -O2 -o %s",
        vim.fn.shellescape(file),
        vim.fn.shellescape(out)
      )
      local run_cmd = vim.fn.shellescape("./" .. out)

      -- Full command run inside bash -lc: compile, run, then wait for a keypress
      local full_cmd = string.format('%s && %s; echo; read -n1 -s -p "Press any key to close..."',
        compile_cmd, run_cmd)

      if vim.env.TMUX and vim.env.TMUX ~= "" then
        -- We're inside tmux: open a NEW tmux WINDOW and run the command there.
        -- It will create the window and switch to it. To create detached, add "-d" after new-window.
        local window_name = out
        vim.fn.jobstart({
          "tmux", "new-window", "-n", window_name, "bash", "-lc", full_cmd
        }, { detach = true })
      else
        -- Fallback: open a Neovim terminal split at the bottom
        vim.cmd(string.format('botright 15split | terminal bash -lc %s', vim.fn.shellescape(full_cmd)))
      end
    end

    vim.keymap.set("n", "<F5>", build_and_run, { buffer = true, desc = "Build and run C++ (clang++)" })
  end,
})
