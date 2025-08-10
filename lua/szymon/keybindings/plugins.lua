--===[ Plugin-specific Keybindings ]===--

local nnoremap = require("szymon.keybindings.keymap_util").nnoremap
local nnoremap_silent = require("szymon.keybindings.keymap_util").nnoremap_silent
local inoremap_silent = require("szymon.keybindings.keymap_util").inoremap_silent
local xnoremap_silent = require("szymon.keybindings.keymap_util").xnoremap_silent

--===[ Custom function wrappers for NERDTree ]===--

--[[ I had to reimplement the toggling functionality because the default one
     would shift the width of the main buffer when having it centered.
     This variable maintains the current state of the tree viewer (open/closed).]]
local NERD_TREE_OPEN = false

-- Forward declaration of the function and state that couples the nerd tree
-- view state and the focus mode.
local FOCUS_MODE_ENABLED, enable_focus_mode

--[[ Wraps around NERDTreeClose while maintaining the information on open/close
     state of the tree. ]]
local function file_tree_toggle()
	if NERD_TREE_OPEN then
		vim.cmd([[ NERDTreeClose ]])
		if FOCUS_MODE_ENABLED then
			enable_focus_mode()
		end
		NERD_TREE_OPEN = false
	else
		vim.cmd([[ NERDTreeFocus ]])
		NERD_TREE_OPEN = true
	end
end

--[[ Wraps around NERDTreeFocus while maintaining the information on open/close
     state of the tree. ]]
local function file_tree_jump()
	if NERD_TREE_OPEN then
		vim.cmd([[ NERDTreeFocus ]])
	end
end

--[[ Wraps around NERDTreeFind while maintaining the information on open/close
     state of the tree. ]]
local function file_tree_find()
	vim.cmd([[ NERDTreeFind ]])
	NERD_TREE_OPEN = true
end

--[[ Maximizes the current buffer and ensures that NERDTree is closed. ]]
local function maximize_current_buffer()
	if vim.fn.winnr("$") > 1 then
		vim.cmd([[ only ]])
	end
	NERD_TREE_OPEN = false
end

--=[ NERDTree keybindings ]=--
nnoremap("<leader>sd", file_tree_toggle)
nnoremap("<leader>sf", file_tree_find)
nnoremap("<leader>sj", file_tree_jump)
nnoremap("<leader>m", maximize_current_buffer)

--=[ Focus Mode ]=--
--[[ Focus mode means that the code is centered on the screen (I need this as
     my main monitor is wide and the head hurts if the code is on the left).
     This is achieved by adding a blank window of size 40 to the left of the
     main code buffer. The problem is that after closing NERDTree this
     can get misaligned, so we need to track the state of the focus mode and
     'refocus' after closing NERDTree. This feature is coupled with the state
     of NERDTree window, so we define this setup in this file.]]
FOCUS_MODE_ENABLED = false

function enable_focus_mode()
	maximize_current_buffer()
	--[[This creates a new blank buffer to the left of the current the width
      is specified to roughly center the original buffer. ]]

	local width = vim.o.columns
	local default_buffer_width = 80
	local centering_margin = (width - default_buffer_width) / 2
	local spawn_buffer = string.format("<cmd>vsp blank | vertical resize %d<CR>", centering_margin)
	local move_focus_back = "<C-w>l"
	local full_command = spawn_buffer .. move_focus_back
	local command = vim.api.nvim_replace_termcodes(full_command, true, false, true)
	vim.api.nvim_feedkeys(command, "n", true)
	FOCUS_MODE_ENABLED = true
end

local function toggle_focus_mode()
	if FOCUS_MODE_ENABLED then
		FOCUS_MODE_ENABLED = false
		maximize_current_buffer()
	else
		FOCUS_MODE_ENABLED = true
		enable_focus_mode()
	end
end

--[[ Enters centered mode on big monitor.
     Need to open and close nerdtree to avoid misalignments ]]
nnoremap("<leader>o", toggle_focus_mode)

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

--===[ Fugitive Keybindings ]===--
vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

--===[ GDB Keybindings ]===--
nnoremap("<leader>tb", "<cmd>GdbBreakpointToggle<cr>")
