-- Version of 01.09.2022.
-- set.lua contains all general vim settings.

-- Line Numbers Settings -------------------------------------------------------
vim.opt.relativenumber = true
vim.opt.nu = true -- Shows the current line number instead of 0.

-- Indentation Settings --------------------------------------------------------
vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.softtabstop = 2
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

-- Search Settings -------------------------------------------------------------
vim.opt.incsearch  = true
vim.opt.hlsearch = false
vim.opt.smartcase = true
vim.opt.ignorecase = true

-- Swap Files and Undo History -------------------------------------------------
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = ".vim/undodir"
vim.opt.undofile = true

-- Visual Indicators -----------------------------------------------------------
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "80"

-- Miscellaneous ---------------------------------------------------------------
vim.opt.exrc = true -- sources init.lua if present in the current working dir.

vim.opt.hidden = true -- keeps files open even if the buffer is not visible.

vim.opt.scrolloff = 8
vim.opt.wrap = false

