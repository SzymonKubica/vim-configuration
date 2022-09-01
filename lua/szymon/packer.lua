-- Version of 01.09.2022.
-- packer.lua specifies all plugins.

vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
	use 'folke/tokyonight.nvim'
	use 'lervag/vimtex'
	use 'SirVer/ultisnips'
	use 'nvim-telescope/telescope.nvim'
	use 'nvim-lua/plenary.nvim' -- Dependency for telescope
end)
