-- remap.lua specifies all keybindings.

local nnoremap = require("szymon.keymap").nnoremap
local vnoremap = require("szymon.keymap").vnoremap
local inoremap = require("szymon.keymap").inoremap
local xnoremap = require("szymon.keymap").xnoremap
local nnoremap_silent = require("szymon.keymap").nnoremap_silent
local inoremap_silent = require("szymon.keymap").inoremap_silent
local xnoremap_silent = require("szymon.keymap").xnoremap_silent

vim.g.mapleader = " " -- The leader key is the one that triggers a keybinding.

-- Reimplemented the toggling functionality because the default one
-- would shift the width of the main buffer when having it centered.
IsNerdTreeOpen = false
function NerdTreeToggle()
  if IsNerdTreeOpen then
    vim.cmd [[ NERDTreeClose ]]
    IsNerdTreeOpen = false
  else
    vim.cmd [[ NERDTreeFocus ]]
    IsNerdTreeOpen = true
  end
end

function NerdTreeJump()
  if IsNerdTreeOpen then
    vim.cmd [[ NERDTreeFocus ]]
  end
end

function NerdTreeFind()
  if IsNerdTreeOpen then
    vim.cmd [[ NERDTreeClose ]]
    IsNerdTreeOpen = false
  else
    vim.cmd [[ NERDTreeFind ]]
    IsNerdTreeOpen = true
  end
end

function MaximizeCurrentBuffer()
  vim.cmd [[ only ]]
  IsNerdTreeOpen = false
end

-- Show current working directory in the tree view.
nnoremap("<leader>sd", "<cmd> lua NerdTreeToggle() <CR>")
-- Show current file in the tree view.
nnoremap("<leader>sf", "<cmd> lua NerdTreeFind() <CR>")
-- Jump to the open tree view.
nnoremap("<leader>sj", "<cmd> lua NerdTreeJump() <CR>")

-- Make the current buffer fullscreen and hid all other buffers
nnoremap("<leader>m", "<cmd> lua MaximizeCurrentBuffer() <CR>")

nnoremap("<leader>b", "<C-^>") -- Makes jumping back to the prev file easier

-- Invokes file formattting
nnoremap("<leader>fo", "<cmd>Neoformat <CR>")

-- Enters centered mode on big monitor
-- Need to open and close nerdtree to avoid misalignments
nnoremap("<leader>o", "<cmd> lua MaximizeCurrentBuffer() <CR><C-w>v <cmd> e blank <CR><C-w>l <C-w>40>")

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

-- Make the current file executable
nnoremap_silent("<leader>ex", "<cmd>!chmod +x %<CR>")

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


-- Git Keybindings -------------------------------------------------------------
nnoremap_silent('<leader>ga', '<cmd>Git add %<cr>')
nnoremap_silent('<leader>gc', '<cmd>lua print(vim.fn.system({\'git\', \'commit\', \'-m\', vim.fn.input(\"Commit message: \")}))<cr>')
nnoremap_silent('<leader>gp', '<cmd>Git push <cr>')

-- LSP Shortcuts ---------------------------------------------------------------
nnoremap_silent('<leader>q', vim.diagnostic.open_float)
nnoremap_silent('[d', vim.diagnostic.goto_prev)
nnoremap_silent(']d', vim.diagnostic.goto_next)
nnoremap_silent('<leader>l', vim.diagnostic.setloclist)

