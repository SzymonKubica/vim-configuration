-- Version of 01.10.2022.
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
vim.opt.expandtab = true

-- Search Settings -------------------------------------------------------------
vim.opt.incsearch  = true
vim.opt.hlsearch = false
vim.opt.smartcase = true
vim.opt.ignorecase = true

-- Netrw Settings --------------------------------------------------------------
vim.g.netrw_keepdir = 0 -- Keeps the current dir and browsing dir in sync
vim.g.netrw_winsize = 30
vim.g.netrw_banner = 0 -- Hides the banner
vim.g.netrw_localcopydircmd = 'cp -r' -- Allows for recursive copying of dirs.
vim.cmd[[hi! link netrwMarkFile Search]] -- Highlights marked files

-- Swap Files and Undo History -------------------------------------------------
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = "/home/szymon/.cache/.vim/undodir"
vim.opt.undofile = true

-- Visual Indicators -----------------------------------------------------------
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "80"

-- Code Completion Settings ----------------------------------------------------
vim.g.completion_enable_fuzzy_match = 1
vim.opt.completeopt = "menuone,noinsert,noselect"
vim.opt.wildmenu = true

-- Miscellaneous ---------------------------------------------------------------
vim.opt.exrc = true -- sources init.lua if present in the current working dir.

vim.opt.hidden = true -- keeps files open even if the buffer is not visible.

vim.opt.scrolloff = 8
vim.opt.wrap = false

vim.g.NERDTreeMapCustomOpen = "L"
vim.g.NERDTreeMinimalUI = 1 -- Removes the help prompt
vim.g.NERDTreeMapChangeRoot = "l"
vim.g.NERDTreeMapUpdir = "h"

-- Typescript formatting using Neoformat
vim.g.neoformat_try_node_exe = 1
