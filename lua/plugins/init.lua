  return {
    'm4xshen/autoclose.nvim',
    'wbthomason/packer.nvim',
	  'folke/tokyonight.nvim',
    'zbirenbaum/copilot.lua',
  {
  "zbirenbaum/copilot-cmp",
  after = { "copilot.lua" },
  config = function ()
    require("copilot_cmp").setup()
  end
  },
  'yorickpeterse/nvim-grey',
  {
    'rose-pine/neovim',
    as = 'rose-pine',
    config = function()
        require("rose-pine").setup({
          groups = {
		        border = 'highlight_med'
          },
          highlight_groups = {
		        ColorColumn = { bg = 'surface' }
	        }
        })
    end
  },
	'nvim-telescope/telescope.nvim',
	'nvim-telescope/telescope-ui-select.nvim',
	'nvim-lua/plenary.nvim', -- Dependency for telescope
  {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
  {'williamboman/mason.nvim',
  build = ":MasonUpdate",
  config = function()
    require("mason").setup()
  end
},
{
  "williamboman/mason-lspconfig.nvim",
  dependencies = {
    'williamboman/mason.nvim',
  },
  config = function()
    require("mason-lspconfig").setup({
      ensure_installed = {
        'arduino_language_server',
        -- We need to install clangd for arduino_language_server to work
        'clangd'
      }
    })
  end
},
	'mbbill/undotree',
	'ellisonleao/gruvbox.nvim',
	'neovim/nvim-lspconfig',
	{
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
        require("nvim-surround").setup({
            -- Configuration here, or leave empty to use defaults
        })
    end
},{
  'filipdutescu/renamer.nvim',
  branch = 'master',
  requires = { {'nvim-lua/plenary.nvim'} }
	},
	-- Plugins for code completion
	'hrsh7th/nvim-cmp', -- Autocompletion plugin,
  'hrsh7th/cmp-nvim-lsp', -- LSP source for nvim-cmp
  'saadparwaiz1/cmp_luasnip', -- Snippets source for nvim-cmp,
  'L3MON4D3/LuaSnip', -- Snippets plugin
  -- Plugins for nerdtree
  'preservim/nerdtree',
  'PhilRunninger/nerdtree-visual-selection', -- Filesystem operations for nerdtree
  'ryanoasis/vim-devicons',
  'Xuyuanp/nerdtree-git-plugin',
  'averms/black-nvim',
{
    "mrcjkb/rustaceanvim",
    version = "^4",
  },
  'lervag/vimtex',
  'sirver/ultisnips',
  -- Lean lsp support
  'Julian/lean.nvim',
  -- Plugins for typescript
  'sbdchd/neoformat',
  'theprimeagen/harpoon',
  'tpope/vim-fugitive',
  -- TLA+ support
  {"susliko/tla.nvim", requires = { "nvim-lua/plenary.nvim" }}}
