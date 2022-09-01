-- Version of 01.09.2022
-- remap.lua specifies all keybindings.

local nnoremap = require("szymon.keymap").nnoremap
local inoremap = require("szymon.keymap").inoremap

vim.g.mapleader = " " -- The leader key is the one that triggers a keybinding.

nnoremap("<leader>pv", "<cmd>Ex<CR>") -- Exit to the directory view.

inoremap("ii", "<Esc>") -- Allows for quickly exiting insert mode.

-- Telescope Keybindings -------------------------------------------------------
nnoremap("<leader>ff", "<cmd>Telescope find_files<cr>")
nnoremap("<leader>fg", "<cmd>Telescope live_grep<cr>")
nnoremap("<leader>fb", "<cmd>Telescope buffers<cr>")
nnoremap("<leader>fh", "<cmd>Telescope help_tags<cr>")
nnoremap("<leader>ps", "<cmd>lua require('telescope.builtin').grep_string({ search = vim.fn.input(\"Grep For > \")})<cr>")





