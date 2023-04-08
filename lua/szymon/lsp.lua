-- Version of 28.09.2022.
-- Add additional capabilities supported by nvim-cmp

local nnoremap = require('szymon.keymap').nnoremap
local inoremap = require('szymon.keymap').inoremap
local capabilities = vim.lsp.protocol.make_client_capabilities()
local lspconfig = require 'lspconfig'
local luasnip = require 'luasnip'
local cmp = require 'cmp'
local rust_tools = require 'rust-tools'
local lean = require 'lean'

-- Automatically shows a box for inline diagnostics when howered.
vim.o.updatetime = 250
vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

-- Copilot setup
require("copilot").setup({
  suggestion = { enabled = false },
  panel = { enabled = false },
})

-- Global mappings for all lsp clients.
local on_attach = function()
      -- Mappings applicable to all buffers.
      nnoremap('gd', '<Cmd>lua vim.lsp.buf.definition()<CR>')
      nnoremap('K', '<Cmd>lua vim.lsp.buf.hover()<CR>')
      nnoremap('gD', '<cmd>lua vim.lsp.buf.implementation()<CR>')
      nnoremap('gr', '<cmd>lua vim.lsp.buf.references()<CR>')
      nnoremap('<leader>a', '<cmd>lua vim.lsp.buf.code_action()<CR>')
      inoremap('<C-i>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
end

-- Enable language servers with the additional completion features from nvim-cmp
local servers = { 'clangd', 'pyright', 'tsserver', 'hls', 'lua_ls', 'texlab'}
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
		on_attach = on_attach,
    capabilities = capabilities,
		settings = {
			haskell = {
					hlintOn = true,
					formattingProvider = 'fourmolu'
			},
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = 'LuaJIT',
          -- Setup your lua path
          path = '/usr/bin/lua',
        },
        diagnostics = {
          globals = {'vim', 'awesome'},
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = {
            vim.fn.expand('$VIMRUNTIME/lua'),
            vim.fn.stdpath('config') .. '/lua'
          },
          checkThridParty = false
        },
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = {
          enable = false,
        },
      },
      cpp = {
        cmd = {
          'clangd',
          '--background-index',
          '-j=12',
          '--query-driver=/usr/bin/**/clang-*,/bin/clang,/bin/clang++,/usr/bin/gcc,/usr/bin/g++',
          '--clang-tidy',
          '--clang-tidy-checks=*',
          '--all-scopes-completion',
          '--cross-file-rename',
          '--completion-style=detailed',
          '--header-insertion-decorators',
          '--header-insertion=iwyu',
          '--pch-storage=memory',
        }
      },
		}
  }
end

-- Rust, Lean and Elixir require some custom configuration and so they
-- are configured separately.

rust_tools.setup({
  server = {
    on_attach = function(_, bufnr)
      -- enable other keybindings
      on_attach()
      -- Hover actions
      vim.keymap.set('n', '<Leader>h', rust_tools.hover_actions.hover_actions, { buffer = bufnr })
      -- Code action groups
      vim.keymap.set('n', '<Leader>a', rust_tools.code_action_group.code_action_group, { buffer = bufnr })
    end,
  },
})

-- Set up the lsp config for lean prover
lean.setup{
  abbreviations = { builtin = true },
  lsp = { on_attach = on_attach },
  lsp3 = { on_attach = on_attach },
  mappings = true,
}

-- Set up the lsp configuration for elixir separately.
lspconfig.elixirls.setup {
  cmd = { 'elixir-ls' },
  on_attach = on_attach,
  capabilities = capabilities
}

-- nvim-cmp setup for autocompletion.
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-f>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
    ['<C-Tab>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = false, -- Only confirm if a suggestion was explicitly selected.
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        --fallback()
        -- fallback doesn't work for some lsp clients
        -- insert two spaces instead.
        vim.api.nvim_feedkeys('  ', 'i', true)
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = {
    { name = 'copilot', group_index = 2 },
    { name = 'path' },                              -- file paths
    { name = 'nvim_lsp', keyword_length = 3 },      -- from language server
    { name = 'luasnip' },
    { name = 'ultisnips' },
    { name = 'nvim_lsp_signature_help'},            -- display function signatures with current parameter emphasized
    { name = 'nvim_lua', keyword_length = 2},       -- complete neovim's Lua runtime API such vim.lsp.*
    { name = 'buffer', keyword_length = 2 },        -- source current buffer
    { name = 'vsnip', keyword_length = 2 },         -- nvim-cmp source for vim-vsnip
    { name = 'calc'},                               -- source for math calculation
  },
  formatting = {
      fields = {'menu', 'abbr', 'kind'},
      format = function(entry, item)
          local menu_icon ={
              nvim_lsp = 'λ',
              vsnip = '⋗',
              buffer = 'Ω',
              path = '..',
          }
          item.menu = menu_icon[entry.source.name]
          return item
      end,
  },
}
