local nnoremap = require("szymon.keybindings.keymap_util").nnoremap
local inoremap = require("szymon.keybindings.keymap_util").inoremap
local capabilities = vim.lsp.protocol.make_client_capabilities()
local lspconfig = require("lspconfig")
local luasnip = require("luasnip")
local cmp = require("cmp")
local lean = require("lean")

-- Automatically shows a box for inline diagnostics when howered.
vim.o.updatetime = 250

--===[ Common keybindings for all LSP clients ]===--
local on_attach = function(client, bufnr)
	-- Mappings applicable to all buffers.
	nnoremap("K", vim.lsp.buf.hover)
	nnoremap("<leader>fi", vim.lsp.buf.implementation)
	nnoremap("gd", vim.lsp.buf.definition)
	nnoremap("<leader>fr", vim.lsp.buf.references)
	nnoremap("Hh", "<cmd>lua vim.lsp.inlay_hint.enable(false, {bufnr = " .. bufnr .. "})<CR>")
	nnoremap("Hs", "<cmd>lua vim.lsp.inlay_hint.enable(true, {bufnr = " .. bufnr .. "})<CR>")
	nnoremap("<leader>a", vim.lsp.buf.code_action)
	inoremap("<C-i>", vim.lsp.buf.signature_help)
end

--===[ Default LSP Config Setup ]===--
local servers = {
	"clangd",
	"pyright",
	"ts_ls",
	"hls",
	"lua_ls",
	"texlab",
	"solidity_ls_nomicfoundation",
	"arduino_language_server",
	"elixir-ls",
}

local lua_settings = {
	runtime = {
		version = "LuaJIT",
		path = "/usr/bin/lua",
	},
	diagnostics = {
		globals = { "vim", "awesome" },
	},
	workspace = {
		-- Make the server aware of Neovim runtime files
		library = {
			vim.fn.expand("$VIMRUNTIME/lua"),
			vim.fn.stdpath("config") .. "/lua",
		},
		checkThridParty = false,
	},
	-- Do not send telemetry data containing a randomized but unique identifier
	telemetry = {
		enable = false,
	},
}

local haskell_settings = {
	hlintOn = true,
	formattingProvider = "fourmolu",
}

local cpp_settings = {
	cmd = {
		"clangd",
		"--background-index",
		"-j=12",
		"--query-driver=/usr/bin/**/clang-*,/bin/clang,/bin/clang++,/usr/bin/gcc,/usr/bin/g++,/home/szymon/.arduino15/**/*",
		"--clang-tidy",
		"--clang-tidy-checks=*",
		"--all-scopes-completion",
		"--cross-file-rename",
		"--enable-config",
		"--completion-style=detailed",
		"--header-insertion-decorators",
		"--header-insertion=iwyu",
		"--pch-storage=memory",
	},
}

for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		on_attach = on_attach,
		capabilities = capabilities,
		settings = {
			haskell = haskell_settings,
			Lua = lua_settings,
			cpp = cpp_settings,
		},
	})
end

--===[ Custom Language-specific LSP Configurations ]===--
--=[ Arduino Lnaguage Server ]=--
-- Setup instructions taken from here: https://github.com/arduino/arduino-language-server/pull/199#issuecomment-2519818108
require("lspconfig").arduino_language_server.setup({
	on_attach = on_attach,
	cmd = {
		"/home/szymon/.local/share/nvim/mason/bin/arduino-language-server",
		"-clangd",
		"/home/szymon/.local/share/nvim/mason/bin/clangd",
		"-cli",
		"/usr/bin/arduino-cli",
		"-cli-config",
		"/home/szymon/.arduino15/arduino-cli.yaml",
		"-fqbn",
		"arduino:renesas_uno:minima",
	},
	root_dir = lspconfig.util.root_pattern("*.ino"),
	filetypes = { "arduino" },
	autostart = true,
	log_level = vim.lsp.protocol.MessageType.Log,
	disabledFeatures = { "semanticTokens" },
	settings = {
		arduino_language_server = {
			log = {
				verbosity = "debug",
			},
		},
	},
	capabilities = {},
})

--=[ Lean Prover LSP configuration ]=--
lean.setup({
	abbreviations = { builtin = true },
	lsp = { on_attach = on_attach },
	lsp3 = { on_attach = on_attach },
	mappings = true,
})

--=[ Rust LSP Configuration ]=--
vim.g.rustaceanvim = {
	-- Plugin configuration
	tools = {},
	-- LSP configuration
	server = {
		on_attach = function(client, bufnr)
			vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
			on_attach(client, bufnr)
		end,

		capabilities = {
			experimental = {
				snippetTextEdit = false,
			},
		},
		default_settings = {
			-- rust-analyzer language server configuration
			["rust-analyzer"] = {},
		},
	},
	-- DAP configuration
	dap = {},
}

--===[ Auto-complete Configuration ]===--
cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	preselect = cmp.PreselectMode.None,
	mapping = cmp.mapping.preset.insert({
		["<C-f>"] = cmp.mapping.scroll_docs(-4),
		["<C-d>"] = cmp.mapping.scroll_docs(4),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = false, -- Only confirm if a suggestion was explicitly selected.
		}),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				--fallback()
				-- fallback doesn't work for some lsp clients
				-- insert two spaces instead.
				vim.api.nvim_feedkeys("  ", "i", true)
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	}),
	sources = {
		{ name = "path" }, -- file paths
		{ name = "nvim_lsp", keyword_length = 3 }, -- from language server
		{ name = "luasnip" },
		{ name = "ultisnips" },
		{ name = "nvim_lsp_signature_help" }, -- display function signatures with current parameter emphasized
		{ name = "nvim_lua", keyword_length = 2 }, -- complete neovim's Lua runtime API such vim.lsp.*
		{ name = "buffer", keyword_length = 2 }, -- source current buffer
		{ name = "vsnip", keyword_length = 2 }, -- nvim-cmp source for vim-vsnip
		{ name = "calc" }, -- source for math calculation
	},
	formatting = {
		fields = { "menu", "abbr", "kind" },
		format = function(entry, item)
			local menu_icon = {
				nvim_lsp = "λ",
				vsnip = "⋗",
				buffer = "Ω",
				path = "..",
			}
			item.menu = menu_icon[entry.source.name]
			return item
		end,
	},
})
