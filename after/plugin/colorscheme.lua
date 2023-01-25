-- Colorscheme Configuration ---------------------------------------------------
vim.g.tokyonight_transparent_sidebar = true
vim.g.tokyonight_transparent = true
vim.opt.background = "dark"

function ApplyColorscheme(color)
  color = color or "rose-pine"
  vim.cmd.colorscheme(color)
end

ApplyColorscheme("tokyonight-night")
