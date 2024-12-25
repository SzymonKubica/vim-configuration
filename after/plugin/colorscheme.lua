-- Colorscheme Configuration ---------------------------------------------------
vim.g.tokyonight_transparent_sidebar = true
vim.g.tokyonight_transparent = true
vim.opt.background = "dark"

function ApplyColorscheme(color)
  color = color or "rose-pine"
  -- Makes a wall at 81 so that it is obvious that characters can go up to 80.
  vim.opt.colorcolumn = "81"
  vim.cmd.colorscheme(color)
end

ApplyColorscheme("rose-pine")
