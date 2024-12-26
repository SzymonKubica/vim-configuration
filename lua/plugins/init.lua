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
	'nvim-lua/plenary.nvim', -- Dependency for telescope
	'nvim-treesitter/nvim-treesitter',
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
    'mrcjkb/rustaceanvim',
    version = '^5', -- Recommended
    lazy = false, -- This plugin is already lazy
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
