--===[ Copilot Configuration ]===--
require("copilot").setup({
	suggestion = {
		enabled = true,
		auto_trigger = true,
		keymap = {
			accept = "<C-]>",
			accept_word = false,
			accept_line = false,
			dismiss = "<C-[>",
			next = "<M-]>",
			prev = "<M-[>",
		},
	},
	panel = { enabled = true, auto_refresh = true },
})
