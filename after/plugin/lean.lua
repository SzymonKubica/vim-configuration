
--===[ Lean LSP Configuration ]===--
local lean = require("lean")

-- Set up the lsp config for lean prover
lean.setup({
	abbreviations = { builtin = true },
	lsp = { on_attach = on_attach },
	lsp3 = { on_attach = on_attach },
	mappings = true,
})
