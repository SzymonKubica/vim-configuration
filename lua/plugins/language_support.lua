--===[ Plugins for dedicated language support ]===--
return {
  --=[ C++ / Arduino ]=--
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"williamboman/mason.nvim",
		},
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"arduino_language_server",
					-- We need to install clangd for arduino_language_server to work
					"clangd",
				},
			})
		end,
	},
  --=[ Rust ]=--
	{
		"mrcjkb/rustaceanvim",
		version = "^4",
	},
  --=[ Lean ]=--
	"Julian/lean.nvim",
  --=[ TLA+ ]=--
	{ "susliko/tla.nvim", requires = { "nvim-lua/plenary.nvim" } },
  --=[ LaTeX ]=--
	"lervag/vimtex",
}
