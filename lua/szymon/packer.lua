-- packer.lua specifies all plugins.

vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  use 'm4xshen/autoclose.nvim'
  use 'wbthomason/packer.nvim'
	use 'folke/tokyonight.nvim'
  use { "zbirenbaum/copilot.lua" }
  use {
  "zbirenbaum/copilot-cmp",
  after = { "copilot.lua" },
  config = function ()
    require("copilot_cmp").setup()
  end
  }
  use 'yorickpeterse/nvim-grey'
  use({
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
  })
	use 'nvim-telescope/telescope.nvim'
	use 'nvim-lua/plenary.nvim' -- Dependency for telescope
	use 'nvim-treesitter/nvim-treesitter'
	use 'mbbill/undotree'
	use 'ellisonleao/gruvbox.nvim'
	use 'neovim/nvim-lspconfig'
  use {
    'kylechui/nvim-surround',
    tag = "*", -- Use for stability; omit to use `main` branch for the latest features
    config = function()
        require("nvim-surround").setup({
            -- Configuration here, or leave empty to use defaults
        })
    end
  }
	use {
  'filipdutescu/renamer.nvim',
  branch = 'master',
  requires = { {'nvim-lua/plenary.nvim'} }
	}
	-- Plugins for code completion
	use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
  use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
  use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
  use 'L3MON4D3/LuaSnip' -- Snippets plugin
  -- Plugins for nerdtree
  use 'preservim/nerdtree'
  use 'PhilRunninger/nerdtree-visual-selection' -- Filesystem operations for nerdtree
  use 'ryanoasis/vim-devicons'
  use 'Xuyuanp/nerdtree-git-plugin'
  use 'averms/black-nvim'
	-- Plugins for rust
	use 'simrat39/rust-tools.nvim'
  -- Plugins for latex
	use 'lervag/vimtex'
  use 'sirver/ultisnips'
  -- Lean lsp support
  use 'Julian/lean.nvim'
  -- Plugins for typescript
  use 'sbdchd/neoformat'
  use 'theprimeagen/harpoon'
  use 'tpope/vim-fugitive'
  -- TLA+ support
  use({"susliko/tla.nvim", requires = { "nvim-lua/plenary.nvim" }})
end)
