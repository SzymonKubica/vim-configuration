--===[ General Settings  ]===--

vim.g.mapleader = " " -- The leader key is the one that triggers a keybinding.

--=[ Line Numbers ]=--
vim.opt.relativenumber = true
vim.opt.nu = true -- Shows the current line number instead of 0.

--=[ Indentation  ]=--
vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.softtabstop = 2
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

--=[ Miscellaneous  ]=--
vim.opt.exrc = true -- sources init.lua if present in the current working dir.
vim.opt.hidden = true -- keeps files open even if the buffer is not visible.
vim.opt.scrolloff = 8
vim.opt.wrap = false
-- Typescript formatting using Neoformat
vim.g.neoformat_try_node_exe = 1

--=[ Search  ]=--
vim.opt.incsearch = true
vim.opt.hlsearch = false
vim.opt.smartcase = true
vim.opt.ignorecase = true

--=[ Swap Files and Undo History ]=--
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = "/home/szymon/.cache/.vim/undodir"
vim.opt.undofile = true

--=[ Visual Indicators ]=--
vim.opt.signcolumn = "yes"
-- Disable the fill chars
vim.cmd([[set fillchars+=eob:\ ]])

--=[ Code Completion ]=--
vim.g.completion_enable_fuzzy_match = 1
vim.opt.completeopt = "menuone,noinsert,noselect"
vim.opt.wildmenu = true
