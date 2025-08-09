local nnoremap = require("szymon.keybindings.keymap_util").nnoremap
local vnoremap = require("szymon.keybindings.keymap_util").vnoremap
local inoremap = require("szymon.keybindings.keymap_util").inoremap
local xnoremap = require("szymon.keybindings.keymap_util").xnoremap
local nnoremap_silent = require("szymon.keybindings.keymap_util").nnoremap_silent

--===[ Editor Keybindings ]===--

--=[ Navigation ]=--
-- Makes jumping back to the prev file easier.
nnoremap("<leader>b", "<C-^>")
-- Centers the cursor after <C-u> and <C-d>
nnoremap("<C-d>", "<C-d>zz")
nnoremap("<C-u>", "<C-u>zz")
-- Centers the cursor after repeating a search
nnoremap("n", "nzz")
nnoremap("N", "Nzz")
-- Allows for quickly exiting insert mode.
inoremap("jk", "<Esc>")
-- Allows for quickly exiting Neovim
nnoremap("<leader><Esc>", "<cmd> qa <CR>")

--=[ Cut / Copy / Paste Overrides ]=--
-- Allows for yanking into the system clipboard
nnoremap("<leader>y", '"+y')
vnoremap("<leader>y", '"+y')
nnoremap("<leader>Y", '"+Y')
-- Deletes into the void register to avoid overwriting the paste buffer.
nnoremap("<leader>d", '"_d')
vnoremap("<leader>d", '"_d')
-- Allows for pasting in visual mode without overwriting the paster buffer
-- it is useful for multiple replacements.
xnoremap("<leader>p", '"_dP')

--=[ Advanced Text Transforms ]=--
-- When appending the line below to the end of the current line forces
-- the cursor to remain at 0.
nnoremap("J", "mzJ`z")
-- Allows for moving the selection
vnoremap("J", ":m '>+1<CR>gv=gv")
vnoremap("K", ":m '<-2<CR>gv=gv")
-- Invokes file formattting.
nnoremap("<leader>fo", "<cmd>Neoformat <CR>")

--=[ Layout Keybindings ]=--
local api = vim.api
local function fit_buffer_width()
	local buf = api.nvim_get_current_buf()
	local lines = api.nvim_buf_get_lines(buf, 0, -1, false)
	-- Get max display width of all lines
	local max_width = 0
	for _, line in ipairs(lines) do
		local width = vim.fn.strdisplaywidth(line)
		max_width = math.max(max_width, width)
	end

	-- Resize the window
	local win = api.nvim_get_current_win()
	api.nvim_win_set_width(win, max_width)
end

nnoremap("<leader>fc", fit_buffer_width)

--===[ Diagnostics Keybindings ]===--
nnoremap_silent("<leader>q", vim.diagnostic.open_float)
nnoremap_silent("[d", vim.diagnostic.goto_prev)
nnoremap_silent("]d", vim.diagnostic.goto_next)
nnoremap_silent("<leader>l", vim.diagnostic.setloclist)

--===[ Messy overrides ]===--

--[[ In some cases copilot suggestions eat the <ESC> key and so we need to
     hit it twice to exit insert mode. This is a workaround for that. Looks like
     this overridea all other <Esc> keybindings that copilot plugin might
     be setting. ]]
inoremap("<Esc>", "<Esc>")
