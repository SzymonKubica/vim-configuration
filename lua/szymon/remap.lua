-- Version of 03.09.2022.
-- remap.lua specifies all keybindings.

local nnoremap = require("szymon.keymap").nnoremap
local nnoremap_silent = require("szymon.keymap").nnoremap_silent
local inoremap = require("szymon.keymap").inoremap
local nmap = require("szymon.keymap").nmap

vim.g.mapleader = " " -- The leader key is the one that triggers a keybinding.

-- Show files directory in tree view.
nnoremap("<leader>sd", "<cmd> Lexplore <CR>")

nnoremap("<leader>b", "<C-^>") -- Makes jumping back to the prev file easier

inoremap("ii", "<Esc>") -- Allows for quickly exiting insert mode.

-- UndoTree Keybindings --------------------------------------------------------
nnoremap("<F5>", "<cmd>UndotreeToggle<CR>")

-- Telescope Keybindings -------------------------------------------------------
nnoremap("<leader>ff", "<cmd>Telescope find_files<cr>")
nnoremap("<leader>fp", "<cmd>Telescope git_files<cr>")
nnoremap("<leader>fg", "<cmd>Telescope live_grep<cr>")
nnoremap("<leader>fb", "<cmd>Telescope buffers<cr>")
nnoremap("<leader>fh", "<cmd>Telescope help_tags<cr>")
nnoremap("<leader>ps", "<cmd>lua require('telescope.builtin').grep_string({ search = vim.fn.input(\"Grep For > \")})<cr>")

-- LSP Shortcuts ---------------------------------------------------------------
nnoremap_silent('<space>e', vim.diagnostic.open_float)
nnoremap_silent('[d', vim.diagnostic.goto_prev)
nnoremap_silent(']d', vim.diagnostic.goto_next)
nnoremap_silent('<space>q', vim.diagnostic.setloclist)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  nnoremap_with_buffer(bufnr)('gD', vim.lsp.buf.declaration)
	nnoremap_with_buffer(bufnr)('gd', vim.lsp.buf.definition)
	nnoremap_with_buffer(bufnr)('K', vim.lsp.buf.hover)
	nnoremap_with_buffer(bufnr)('gi', vim.lsp.buf.implementation)
	nnoremap_with_buffer(bufnr)('<C-k>', vim.lsp.buf.signature_help)
	nnoremap_with_buffer(bufnr)('<space>wa', vim.lsp.buf.add_workspace_folder)
	nnoremap_with_buffer(bufnr)('<space>wr', vim.lsp.buf.remove_workspace_folder)
  nnoremap_with_buffer(bufnr)('<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end)
  nnoremap_silent(buffer)('<space>D', vim.lsp.buf.type_definition)
	nnoremap_silent(buffer)('<space>rn', vim.lsp.buf.rename)
	nnoremap_silent(buffer)('<space>ca', vim.lsp.buf.code_action)
	nnoremap_silent(buffer)('gr', vim.lsp.buf.references)
	nnoremap_silent(buffer)('<space>f', vim.lsp.buf.formatting)
end

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}
require('lspconfig')['pyright'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
}
