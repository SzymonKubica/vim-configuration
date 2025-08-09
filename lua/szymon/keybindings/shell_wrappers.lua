local nnoremap_silent = require("szymon.keybindings.keymap_util").nnoremap_silent

--===[ Shell-wrapper Keybindings ]===--
-- Make the current file executable.
nnoremap_silent("<leader>ex", "<cmd>!chmod +x %<CR>")

--=[ Git Keybindings (hand-rolled prior to migrating to Git Fugitive) ]=--
-- Add the current buffer to git.
nnoremap_silent("<leader>ga", "<cmd>Git add %<cr>")
-- Commit all staged changes.
nnoremap_silent(
	"<leader>gc",
	"<cmd>lua print(vim.fn.system({'git', 'commit', '-m', vim.fn.input(\"Commit message: \")}))<cr>"
)
-- Git push.
nnoremap_silent("<leader>gp", "<cmd>Git push <cr>")
