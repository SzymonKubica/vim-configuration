--===[ Copilot Configuration ]===--
require("copilot").setup({
	suggestion = {
		enabled = true,
		auto_trigger = true,
		keymap = {
			accept = "<M-j>",
			accept_word = "<M-l>",
			accept_line = false,
			dismiss = "<M-h>",
			next = "<M-]>",
			prev = "<M-[>",
		},
	},
	panel = { enabled = true, auto_refresh = true },
})
