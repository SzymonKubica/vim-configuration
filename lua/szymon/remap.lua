-- Version of 02.10.2022.
-- remap.lua specifies all keybindings.

local nnoremap = require("szymon.keymap").nnoremap
local vnoremap = require("szymon.keymap").vnoremap
local inoremap = require("szymon.keymap").inoremap
local xnoremap = require("szymon.keymap").xnoremap
local nnoremap_silent = require("szymon.keymap").nnoremap_silent
local inoremap_silent = require("szymon.keymap").inoremap_silent
local xnoremap_silent = require("szymon.keymap").xnoremap_silent
local nmap = require("szymon.keymap").nmap

vim.g.mapleader = " " -- The leader key is the one that triggers a keybinding.

-- Show files directory in tree view.
nnoremap("<leader>sd", "<cmd> NERDTreeToggle % <CR>")

-- Make the current buffer fullscreen and hid all other buffers
nnoremap("<leader>m", "<cmd> only <CR>")

nnoremap("<leader>b", "<C-^>") -- Makes jumping back to the prev file easier

-- Invokes file formattting
nnoremap("<leader>fo", "<cmd>Neoformat <CR>") -- Makes jumping back to the prev file easier

-- Enters centered mode on big monitor
-- Need to open and close nerdtree to avoid misalignments
nnoremap("<leader>o", "<cmd> only <CR><C-w>v <cmd> e blank <CR><C-w>l <C-w>40>")

nnoremap("<leader><Esc>", "<cmd> qa <CR>")

inoremap("ii", "<Esc>") -- Allows for quickly exiting insert mode.

-- Centers the cursor after <C-u> and <C-d>
nnoremap("<C-d>", "<C-d>zz")
nnoremap("<C-u>", "<C-u>zz")

-- When appending the line below to the end of the current line forces
-- the cursor to remain at 0.
nnoremap("J", "mzJ`z")

-- Centers the cursor after repeating a search
nnoremap("n", "nzz")
nnoremap("N", "Nzz")

-- Allows for moving the selection
vnoremap("J", ":m '>+1<CR>gv=gv")
vnoremap("K", ":m '<-2<CR>gv=gv")

-- Allows for yanking into the system clipboard
nnoremap("<leader>y", "\"+y")
vnoremap("<leader>y", "\"+y")
nnoremap("<leader>Y", "\"+Y")

-- Deletes into the void register to avoid overwriting the paste buffer.
nnoremap("<leader>d", "\"_d")
vnoremap("<leader>d", "\"_d")

-- Allows for pasting in visual mode without overwriting the paster buffer
-- it is useful for multiple replacements.
xnoremap("<leader>p", "\"_dP")
nnoremap_silent("<leader>ex", "<cmd>!chmod +x %<CR>")

-- Make the current file executable

-- UndoTree Keybindings --------------------------------------------------------
nnoremap("<F5>", "<cmd>UndotreeToggle<CR>")

-- Telescope Keybindings -------------------------------------------------------
nnoremap("<leader>ff", "<cmd>Telescope find_files<cr>")
nnoremap("<leader>fr", "<cmd>Telescope resume<cr>")
nnoremap("<leader>fp", "<cmd>Telescope git_files<cr>")
nnoremap("<leader>fg", "<cmd>Telescope live_grep<cr>") -- You need to have ripgrep installled for this to work.
nnoremap("<leader>fb", "<cmd>Telescope buffers<cr>")
nnoremap("<leader>fh", "<cmd>Telescope help_tags<cr>")
nnoremap("<leader>ps", "<cmd>lua require('telescope.builtin').grep_string({ search = vim.fn.input(\"Grep For > \")})<cr>")
nnoremap("<leader>td", "<cmd>lua require('telescope.builtin').grep_string({ search = 'todo'})<cr>")

-- Rename Keybindings ----------------------------------------------------------
inoremap_silent('<F2>', '<cmd>lua require("renamer").rename()<cr>')
nnoremap_silent('<leader>rn', '<cmd>lua require("renamer").rename()<cr>')
xnoremap_silent('<leader>rn', '<cmd>lua require("renamer").rename()<cr>')

-- LSP Shortcuts ---------------------------------------------------------------
nnoremap_silent('<leader>q', vim.diagnostic.open_float)
nnoremap_silent('[d', vim.diagnostic.goto_prev)
nnoremap_silent(']d', vim.diagnostic.goto_next)
nnoremap_silent('<leader>l', vim.diagnostic.setloclist)
