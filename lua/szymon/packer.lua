 -- Version of 01.10.2022.
-- packer.lua specifies all plugins.

vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
	use 'folke/tokyonight.nvim'
	use 'nvim-telescope/telescope.nvim'
	use 'nvim-lua/plenary.nvim' -- Dependency for telescope
	use 'nvim-treesitter/nvim-treesitter'
	use 'mbbill/undotree'
	use 'ellisonleao/gruvbox.nvim'
	use 'neovim/nvim-lspconfig'
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
  use 'karb94/neoscroll.nvim'
  use 'averms/black-nvim'
	-- Plugins for rust
	use 'simrat39/rust-tools.nvim'
  -- Plugins for latex
	use 'lervag/vimtex'
  use 'sirver/ultisnips'
  -- Plugins for typescript
  use 'sbdchd/neoformat'
end)
