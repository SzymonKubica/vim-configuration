-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
	use 'folke/tokyonight.nvim'
	use 'lervag/vimtex'
	use 'SirVer/ultisnips'
end)
