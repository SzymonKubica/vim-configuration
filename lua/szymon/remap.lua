-- Version of 21.09.2022.
-- remap.lua specifies all keybindings.

local nnoremap = require("szymon.keymap").nnoremap
local inoremap = require("szymon.keymap").inoremap
local xnoremap = require("szymon.keymap").xnoremap
local nnoremap_silent = require("szymon.keymap").nnoremap_silent
local inoremap_silent = require("szymon.keymap").inoremap_silent
local xnoremap_silent = require("szymon.keymap").xnoremap_silent
local nmap = require("szymon.keymap").nmap

vim.g.mapleader = " " -- The leader key is the one that triggers a keybinding.

-- Show files directory in tree view.
nnoremap("<leader>sd", "<cmd> NERDTreeToggle <CR>")

nnoremap("<leader>b", "<C-^>") -- Makes jumping back to the prev file easier

-- NerdTree create new file mapping

nnoremap("<leader> n", "cd <cmd> e")

inoremap("ii", "<Esc>") -- Allows for quickly exiting insert mode.

-- Allows for pasting in visual mode without overwriting the paster buffer
-- it is useful for multiple replacements.
xnoremap("<leader>p", "\"_dP")

-- UndoTree Keybindings --------------------------------------------------------
nnoremap("<F5>", "<cmd>UndotreeToggle<CR>")

-- Telescope Keybindings -------------------------------------------------------
nnoremap("<leader>ff", "<cmd>Telescope find_files<cr>")
nnoremap("<leader>fp", "<cmd>Telescope git_files<cr>")
nnoremap("<leader>fg", "<cmd>Telescope live_grep<cr>")
nnoremap("<leader>fb", "<cmd>Telescope buffers<cr>")
nnoremap("<leader>fh", "<cmd>Telescope help_tags<cr>")
nnoremap("<leader>ps", "<cmd>lua require('telescope.builtin').grep_string({ search = vim.fn.input(\"Grep For > \")})<cr>")

-- Rename Keybindings ----------------------------------------------------------
inoremap_silent('<F2>', '<cmd>lua require("renamer").rename()<cr>')
nnoremap_silent('<leader>rn', '<cmd>lua require("renamer").rename()<cr>')
xnoremap_silent('<leader>rn', '<cmd>lua require("renamer").rename()<cr>')

-- LSP Shortcuts ---------------------------------------------------------------
nnoremap_silent('<space>e', vim.diagnostic.open_float)
nnoremap_silent('[d', vim.diagnostic.goto_prev)
nnoremap_silent(']d', vim.diagnostic.goto_next)
nnoremap_silent('<space>q', vim.diagnostic.setloclist)
