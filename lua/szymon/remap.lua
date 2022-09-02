-- Version of 02.09.2022.
-- remap.lua specifies all keybindings.

local nnoremap = require("szymon.keymap").nnoremap
local inoremap = require("szymon.keymap").inoremap
local nmap = require("szymon.keymap").nmap

vim.g.mapleader = " " -- The leader key is the one that triggers a keybinding.

-- Show filed directory in tree view.
nnoremap("<leader>sd", "<cmd> Lexplore <CR>")

nnoremap("<leader>b", "<C-^>") -- Makes jumping back to the prev file easier

inoremap("ii", "<Esc>") -- Allows for quickly exiting insert mode.

-- UndoTree Keybindings --------------------------------------------------------
nnoremap("<F5>", "<cmd>UndotreeToggle<CR>")

-- Telescope Keybindings -------------------------------------------------------
nnoremap("<leader>ff", "<cmd>Telescope find_files<cr>")
nnoremap("<leader>fg", "<cmd>Telescope live_grep<cr>")
nnoremap("<leader>fb", "<cmd>Telescope buffers<cr>")
nnoremap("<leader>fh", "<cmd>Telescope help_tags<cr>")
nnoremap("<leader>ps", "<cmd>lua require('telescope.builtin').grep_string({ search = vim.fn.input(\"Grep For > \")})<cr>")
