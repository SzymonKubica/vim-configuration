-- Version of 21.09.2022.
-- init.lua resolves all configuration dependencies.
require("szymon.set")
require("szymon.remap")
require("szymon.autocmd")
require("szymon.lsp")

-- Starts up NERDTree if no file arguments are given.
vim.cmd("autocmd VimEnter * if !argc() | NERDTree | endif")

-- Exit Vim if NERDTree is the only window remaining in the only tab.
vim.cmd("autocmd BufEnter * if tabpagenr('$') == 1 " ..
"&& winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif")
