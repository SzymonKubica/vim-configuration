--===[ Miscellaneous Plugins ]===--

--[[ Provides ability to replace characters surrounding a given work / piece
     of text, e.g. changing quotes to brackets. ]]
local nvim_surround = {
	"kylechui/nvim-surround",
	version = "*", -- Use for stability; omit to use `main` branch for the latest features
	event = "VeryLazy",
	config = function()
		require("nvim-surround").setup({
			-- Configuration here, or leave empty to use defaults
		})
	end,
}

-- Provides ability to rename variables, functions, etc. with an nice UI.
local renamer = {
	"filipdutescu/renamer.nvim",
	branch = "master",
	requires = { { "nvim-lua/plenary.nvim" } },
}

-- Provides rich AST-based syntax highlighting.
local treesitter = { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" }

return {
	-- Adds ability for auto-closing brackets, quotes, etc.
	{ "windwp/nvim-autopairs", event = "InsertEnter", config = true },
	nvim_surround,
	renamer,
	treesitter,
	-- Provides ability to quickly switch between buffers by fuzzy searching.
	"nvim-telescope/telescope.nvim",
	-- Dependency for Telescope.
	"nvim-lua/plenary.nvim",
	-- Allows for using telescope as a UI select menu e.g. for LSP code actions.
	"nvim-telescope/telescope-ui-select.nvim",
	-- Allows for quickly jumping between a set of four files tied to keys.
	"theprimeagen/harpoon",
	--[[ Provides a history tree of undo/redo actions allowing to get into
       history places that are not reachable with the default undo/redo. ]]
	"mbbill/undotree",
	-- Provides Git integration for Neovim.
	"tpope/vim-fugitive",
}
