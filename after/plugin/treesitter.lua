-- Treesitter Configuration ----------------------------------------------------
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "c", "cpp", "typescript", "lua", "rust", "python", "java", "haskell", "latex", "elixir", "heex", "eex"},

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  auto_install = true,

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

		-- List of parsers to disable the extension for
    disable = { "latex" },

    additional_vim_regex_highlighting = false,
  },
	incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
}
