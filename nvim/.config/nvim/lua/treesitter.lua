vim.api.nvim_create_autocmd("FileType", {
    callback = function()
        pcall(vim.treesitter.start)
    end,
})

-- Warn if a wanted parser is missing (install manually via tree-sitter-cli or Arch packages)
for _, lang in ipairs({ "go", "javascript", "typescript", "tsx" }) do
    local ok = vim.treesitter.language.add(lang)
    if not ok then
        vim.notify("treesitter: parser missing for '" .. lang .. "'", vim.log.levels.WARN)
    end
end

vim.wo[0][0].foldmethod = "expr"
vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
