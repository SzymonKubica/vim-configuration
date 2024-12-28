-- Add additional capabilities supported by nvim-cmp

local nnoremap = require('szymon.keymap').nnoremap
local inoremap = require('szymon.keymap').inoremap
local capabilities = vim.lsp.protocol.make_client_capabilities()
local lspconfig = require 'lspconfig'
local luasnip = require 'luasnip'
local cmp = require 'cmp'
local lean = require 'lean'

-- Automatically shows a box for inline diagnostics when howered.
vim.o.updatetime = 250

-- Initializes the Rust lsp setup.


-- Copilot setup
require("copilot").setup({
  suggestion = { enabled = false },
  panel = { enabled = false },
})

-- Global mappings for all lsp clients.
local on_attach = function(client, bufnr)
  -- Mappings applicable to all buffers.
  nnoremap('gd', '<Cmd>lua vim.lsp.buf.definition()<CR>')
  nnoremap('K', '<Cmd>lua vim.lsp.buf.hover()<CR>')
  nnoremap('gD', '<cmd>lua vim.lsp.buf.implementation()<CR>')
  nnoremap('gr', '<cmd>lua vim.lsp.buf.references()<CR>')
  nnoremap('Hh', '<cmd>lua vim.lsp.inlay_hint.enable(false, {bufnr = '.. bufnr ..'})<CR>')
  nnoremap('Hs', '<cmd>lua vim.lsp.inlay_hint.enable(true, {bufnr = '.. bufnr ..'})<CR>')
  nnoremap('<leader>a', '<cmd>lua vim.lsp.buf.code_action()<CR>')
  inoremap('<C-i>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')

end


-- Enable language servers with the additional completion features from nvim-cmp
local servers = { 'clangd', 'pyright', 'ts_ls', 'hls', 'lua_ls', 'texlab', 'solidity_ls_nomicfoundation', 'arduino_language_server' }
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
          globals = { 'vim', 'awesome' },
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

-- Setup instructions taken from here: https://github.com/arduino/arduino-language-server/pull/199#issuecomment-2519818108
require('lspconfig').arduino_language_server.setup {
    cmd = {
        "/home/szymon/.local/share/nvim/mason/bin/arduino-language-server",
        "-clangd", "/home/szymon/.local/share/nvim/mason/bin/clangd",
        "-cli", "/usr/bin/arduino-cli",
        "-cli-config", "/home/szymon/.arduino15/arduino-cli.yaml",
        "-fqbn", "arduino:renesas_uno:unor4wifi"
    },
    root_dir = lspconfig.util.root_pattern("*.ino"),
    filetypes = { "arduino" },
    autostart = true,
    log_level = vim.lsp.protocol.MessageType.Log,
    settings = {
        arduino_language_server = {
            log = {
                verbosity = "debug"
            }
        }
    }
}

-- Lean and Elixir require some custom configuration and so they
-- are configured separately.
--

-- Set up the lsp config for lean prover
lean.setup {
  abbreviations = { builtin = true },
  lsp = { on_attach = on_attach },
  lsp3 = { on_attach = on_attach },
  mappings = true,
}

vim.g.rustaceanvim = {
  -- Plugin configuration
  tools = {
  },
  -- LSP configuration
  server = {
    on_attach = function(client, bufnr)
        vim.lsp.inlay_hint.enable(true, {bufnr = bufnr})
        on_attach(client, bufnr)
    end,

    --Trying to set it so that the rust analyzer works on esp32 targets.
    -- imports = {
    --   granularity = {
    --     group = "module",
    --   },
    --   prefix = "self",
    -- },
    -- cargo = {
    --   buildScripts = {
    --     enable = true,
    --   },
    --   target = { "x86_64-unknown-linux-gnu" },
    -- },
    -- procMacro = {
    --   enable = false
    -- },
  capabilities = {
    experimental = {
      snippetTextEdit = false,
  },},
    default_settings = {
      -- rust-analyzer language server configuration
      ['rust-analyzer'] = {
      },
  },
  },
  -- DAP configuration
  dap = {
  },
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
  preselect = cmp.PreselectMode.None,
  mapping = cmp.mapping.preset.insert({
    ['<C-f>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
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
    { name = 'path' }, -- file paths
    { name = 'nvim_lsp', keyword_length = 3 }, -- from language server
    { name = 'luasnip' },
    { name = 'ultisnips' },
    { name = 'copilot', group_index = 2 },
    { name = 'nvim_lsp_signature_help' }, -- display function signatures with current parameter emphasized
    { name = 'nvim_lua', keyword_length = 2 }, -- complete neovim's Lua runtime API such vim.lsp.*
    { name = 'buffer', keyword_length = 2 }, -- source current buffer
    { name = 'vsnip', keyword_length = 2 }, -- nvim-cmp source for vim-vsnip
    { name = 'calc' }, -- source for math calculation
  },
  formatting = {
    fields = { 'menu', 'abbr', 'kind' },
    format = function(entry, item)
      local menu_icon = {
        nvim_lsp = 'λ',
        vsnip = '⋗',
        buffer = 'Ω',
        path = '..',
        copilot = '🤖',
      }
      item.menu = menu_icon[entry.source.name]
      return item
    end,
  },
}
-- Set up Telescope to handle code actions selections
require("telescope").setup {
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {
        -- even more opts
      }
    }
  }
}
-- To get ui-select loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require("telescope").load_extension("ui-select")
