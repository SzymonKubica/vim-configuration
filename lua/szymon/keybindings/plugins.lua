-- remap.lua specifies all keybindings.

local nnoremap = require("szymon.keybindings.keymap_util").nnoremap
local nnoremap_silent = require("szymon.keybindings.keymap_util").nnoremap_silent
local inoremap_silent = require("szymon.keybindings.keymap_util").inoremap_silent
local xnoremap_silent = require("szymon.keybindings.keymap_util").xnoremap_silent

--===[ Custom function wrappers for NERDTree ]===--

--[[ I had to reimplement the toggling functionality because the default one
     would shift the width of the main buffer when having it centered.
     This variable maintains the current state of the tree viewer (open/closed).]]
local NERD_TREE_OPEN = false

--[[ Wraps around NERDTreeClose while maintaining the information on open/close
     state of the tree. ]]
function FileTreeToggle()
	if NERD_TREE_OPEN then
		vim.cmd([[ NERDTreeClose ]])
		NERD_TREE_OPEN = false
	else
		vim.cmd([[ NERDTreeFocus ]])
		NERD_TREE_OPEN = true
	end
end

--[[ Wraps around NERDTreeFocus while maintaining the information on open/close
     state of the tree. ]]
function FileTreeJump()
	if NERD_TREE_OPEN then
		vim.cmd([[ NERDTreeFocus ]])
	end
end

--[[ Wraps around NERDTreeFind while maintaining the information on open/close
     state of the tree. ]]
function FileTreeFind()
	vim.cmd([[ NERDTreeFind ]])
	NERD_TREE_OPEN = true
end

--[[ Maximizes the current buffer and ensures that NERDTree is closed. ]]
function MaximizeCurrentBuffer()
	vim.cmd([[ only ]])
	NERD_TREE_OPEN = false
end

--=[ NERDTree keybindings ]=--

nnoremap("<leader>sd", FileTreeToggle)
nnoremap("<leader>sf", FileTreeFind)
nnoremap("<leader>sj", FileTreeJump)
nnoremap("<leader>m", MaximizeCurrentBuffer)

-- This is currently not necessary, as the editor behaves as expected, we'll need
-- however this note remains should it break in the future. and I need to go back
-- and fix it.
--[[ Focus mode means that the code is centered on the screen (I need this as
     my main monitor is wide and the head hurts if the code is on the left).
     This is achieved by adding a blank window of size 40 to the left of the
     main code buffer. The problem is that after closing NERDTree this
     can get misaligned, so we need to track the state of the focus mode and
     'refocus' after closing NERDTree.]]
local FOCUS_MODE_ENABLED = false

-- Enters centered mode on big monitor
-- Need to open and close nerdtree to avoid misalignments
nnoremap("<leader>o", "<cmd> lua MaximizeCurrentBuffer() <CR><C-w>v <cmd> e blank <CR><C-w>l <C-w>40>")

--===[ UndoTree Keybindings ]===--
nnoremap("<F5>", "<cmd>UndotreeToggle<CR>")

--===[ Telescope Keybindings ]===--
nnoremap("<leader>ff", "<cmd>Telescope find_files<cr>")
nnoremap("<leader>fr", "<cmd>Telescope resume<cr>")
nnoremap("<leader>fp", "<cmd>Telescope git_files<cr>")
nnoremap("<leader>fg", "<cmd>Telescope live_grep<cr>") -- You need to have ripgrep installled for this to work.
nnoremap("<leader>fb", "<cmd>Telescope buffers<cr>")
nnoremap("<leader>fh", "<cmd>Telescope help_tags<cr>")
nnoremap(
	"<leader>ps",
	"<cmd>lua require('telescope.builtin').grep_string({ search = vim.fn.input(\"Grep For > \")})<cr>"
)
nnoremap("<leader>td", "<cmd>lua require('telescope.builtin').grep_string({ search = 'todo'})<cr>")

--===[ Rename Keybindings ]===--
inoremap_silent("<F2>", '<cmd>lua require("renamer").rename()<cr>')
nnoremap_silent("<leader>rn", '<cmd>lua require("renamer").rename()<cr>')
xnoremap_silent("<leader>rn", '<cmd>lua require("renamer").rename()<cr>')
