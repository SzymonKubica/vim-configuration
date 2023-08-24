-- Version of 01.10.2022.
-- autocmd.lua contains all commands that are triggered automatically.

-- Automatically trims trailing whitespace on write
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  command = [[%s/\s\+$//e]],
})

-- Autoformatting on file save
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*.js", "*.ts", "*.ex", ".hs" },
  command = [[Neoformat]],
})


-- Set tabs 8 spaces wide for c
vim.api.nvim_create_autocmd({ "BufEnter" }, {
  pattern = { "*.h", "*.c" },
  command = [[setlocal tabstop=4 shiftwidth=4 expandtab softtabstop=4]],
})
