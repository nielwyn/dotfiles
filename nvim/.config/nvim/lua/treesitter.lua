require("nvim-treesitter").setup({
    install_dir = vim.fn.stdpath("data") .. "/site",
})

require("nvim-treesitter").install({ "go", "javascript", "typescript", "tsx", "svelte", "html", "css" })

vim.api.nvim_create_autocmd("FileType", {
    callback = function()
        if not pcall(vim.treesitter.start) then
            return
        end
        vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
        vim.wo[0][0].foldmethod = "expr"
    end,
})
