-- Colorscheme Configuration ---------------------------------------------------
vim.g.tokyonight_transparent_sidebar = true
vim.g.tokyonight_transparent = true
vim.opt.background = "dark"

function ApplyColorscheme(color)
  color = color or "tokyonight-night"
  vim.cmd.colorscheme(color)
end

ApplyColorscheme()
