--===[ Plugins required for GitHub Copilot support ]===--
return {
	"zbirenbaum/copilot.lua",
	{
		"zbirenbaum/copilot-cmp",
		after = { "copilot.lua" },
		config = function()
			require("copilot_cmp").setup()
		end,
	},
}
