
-- When starting up vim using 'vim .' executes the vimrc file present in
-- that directory
vim.opt.exrc = true


-- Shows the current line number instead of 0
vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.hlsearch = false

-- Indentation 
vim.opt.smartindent = false
vim.opt.smarttab = false
vim.opt.softtabstop = 2
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

vim.opt.wrap = false

-- Allows keeping files open in the buffer even if they aren't currently viewed
vim.opt.hidden = true


vim.opt.incsearch  = true
vim.opt.smartcase = true
vim.opt.ignorecase = true


-- Setup swap file behaviour and undo history
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = ".vim/undodir"
vim.opt.undofile = true

-- Sets the leader key for remapping to be the space key.
vim.g.mapleader = " "

