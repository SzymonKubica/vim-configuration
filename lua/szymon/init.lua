-- init.lua includes all configuration dependencies.
require("szymon.lazy")

-- Important to load set before keybindings as it configures the leader key.
require("szymon.set")
require("szymon.keybindings.editor")
require("szymon.keybindings.plugins")
require("szymon.keybindings.shell_wrappers")
require("szymon.autocmd")
require("szymon.lsp")

-- Starts up NERDTree if no file arguments are given.
vim.cmd("autocmd VimEnter * if !argc() | NERDTree | only | endif")
