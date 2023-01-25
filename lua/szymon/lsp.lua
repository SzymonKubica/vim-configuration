-- Version of 28.09.2022.
-- Add additional capabilities supported by nvim-cmp

local nnoremap = require("szymon.keymap").nnoremap
local inoremap = require("szymon.keymap").inoremap
local capabilities = vim.lsp.protocol.make_client_capabilities()

local lspconfig = require('lspconfig')

-- Enable lua lsp server.

-- Setup the rust-analyzer separately as it is managed by the rust-nvim plugin.
local rt = require("rust-tools")

rt.setup({
  server = {
    on_attach = function(_, bufnr)
      -- Hover actions
      vim.keymap.set("n", "<Leader>h", rt.hover_actions.hover_actions, { buffer = bufnr })
      -- Code action groups
      vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
    end,
  },
})

local on_attach = function(client)
      -- Mappings
      nnoremap('gd', '<Cmd>lua vim.lsp.buf.definition()<CR>')
      nnoremap('K', '<Cmd>lua vim.lsp.buf.hover()<CR>')
      nnoremap('gD', '<cmd>lua vim.lsp.buf.implementation()<CR>')
      nnoremap('gr', '<cmd>lua vim.lsp.buf.references()<CR>')
      nnoremap('<leader>a', '<cmd>lua vim.lsp.buf.code_action()<CR>')
      inoremap('<C-i>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')

      -- autoformat only for haskell
      if vim.api.nvim_buf_get_option(0, 'filetype') == 'haskell' then
          vim.api.nvim_command[[
              autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()]]
      end
end


-- Set up the lsp config for lean prover.
require('lean').setup{
  abbreviations = { builtin = true },
  lsp = { on_attach = on_attach },
  lsp3 = { on_attach = on_attach },
  mappings = true,
}

-- Enable language servers with the additional completion features from nvim-cmp
local servers = { 'clangd', 'pyright', 'tsserver', 'hls', 'sumneko_lua', 'texlab'}
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
		on_attach = on_attach,
    capabilities = capabilities,
		settings = {
			haskell = {
					hlintOn = true,
					formattingProvider = "fourmolu"
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
          "clangd",
          "--background-index",
          "-j=12",
          "--query-driver=/usr/bin/**/clang-*,/bin/clang,/bin/clang++,/usr/bin/gcc,/usr/bin/g++",
          "--clang-tidy",
          "--clang-tidy-checks=*",
          "--all-scopes-completion",
          "--cross-file-rename",
          "--completion-style=detailed",
          "--header-insertion-decorators",
          "--header-insertion=iwyu",
          "--pch-storage=memory",
        }
      },
		}
  }
end

-- Set up the lsp configuration for elixir separately.
lspconfig.elixirls.setup {
  cmd = { "elixir-ls" },
  on_attach = on_attach,
  capabilities = capabilities
}
-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'
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
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'ultisnips' },
  },
}
