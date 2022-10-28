-- Version of 01.10.2022.
-- autocmd.lua contains all commands that are triggered automatically.

-- Automatically trims trailing whitespace on write
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  command = [[%s/\s\+$//e]],
})
-- Automatically formats python with black
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "python" },
  command = [[!black %]],
})
