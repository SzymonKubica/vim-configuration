-- Colorscheme Configuration ---------------------------------------------------
vim.g.tokyonight_transparent_sidebar = true
vim.g.tokyonight_transparent = true
vim.opt.background = "dark"

function ApplyColorscheme(color)
  color = color or "rose-pine"
  -- Makes a wall at 81 so that it is obvious that characters can go up to 80.
  vim.opt.colorcolumn = "81"
  vim.cmd.colorscheme(color)
  -- Get the background dynamically after setting the color scheme
  local bg = vim.api.nvim_get_hl_by_name('Normal', true).background
  vim.api.nvim_set_hl(0, "LspInlayHint", { bg = bg, fg = '#6e6a86' })
end

ApplyColorscheme("rose-pine")
