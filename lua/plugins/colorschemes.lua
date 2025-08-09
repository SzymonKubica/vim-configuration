--===[ Plugins with color scheme definitions ]===--
return {
	"folke/tokyonight.nvim",
	"yorickpeterse/nvim-grey",
	"ellisonleao/gruvbox.nvim",
	{
		"rose-pine/neovim",
		as = "rose-pine",
		config = function()
			require("rose-pine").setup({
				groups = {
					border = "highlight_med",
				},
				highlight_groups = {
					ColorColumn = { bg = "surface" },
				},
			})
		end,
	},
}
