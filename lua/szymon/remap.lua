local nnoremap = require("szymon.keymap").nnoremap
local inoremap = require("szymon.keymap").inoremap


-- By pressing 'space+pv' exit to the directory view
nnoremap("<leader>pv", "<cmd>Ex<CR>")
-- Allows for exiting the insert mode quickly by pressing 'ii'. 
inoremap("ii", "<Esc>")
