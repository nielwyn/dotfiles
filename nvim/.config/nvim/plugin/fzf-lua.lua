require("fzf-lua").setup({
    "fzf-tmux",
    defaults = {
        formatter = "path.filename_first",
    },
    fzf_opts = {
        ["--tmux"] = "center,100%,100%",
        ["--sort"] = true,
    },
    winopts = {
        height = 1,
        width = 1,
        preview = {
            layout = "vertical",
        },
    },
    previewers = {
        bat = {
            args = "--color=always --style=numbers,changes,header --theme=TwoDark",
        },
    },
})

vim.keymap.set("n", "<Leader>fr", "<cmd>FzfLua live_grep resume=true<CR>")
vim.keymap.set("n", "<Leader>fc", "<cmd>FzfLua lgrep_curbuf<CR>")
vim.keymap.set("n", "<Leader>fb", "<cmd>FzfLua buffers<CR>")
vim.keymap.set("n", "<Leader>fa", "<cmd>FzfLua live_grep<CR>")
vim.keymap.set("n", "<Leader>fw", "<cmd>FzfLua grep_cword<CR>")
vim.keymap.set("n", "<Leader>ff", "<cmd>FzfLua files<CR>")
vim.keymap.set("n", "<Leader>fh", "<cmd>FzfLua helptags<CR>")
vim.keymap.set("n", "<Leader>fo", "<cmd>FzfLua oldfiles<CR>")
vim.keymap.set("n", "<Leader>fs", "<cmd>FzfLua git_status<CR>")
vim.keymap.set("n", "<Leader>o", "<cmd>FzfLua lsp_document_symbols<CR>")
