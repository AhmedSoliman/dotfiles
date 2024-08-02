local g = vim.g
local cmd = vim.cmd
local fn = vim.fn
local set_theme_path = "$HOME/.config/tinted-theming/set_theme.lua"
local is_set_theme_file_readable = fn.filereadable(fn.expand(set_theme_path)) == 1 and true or false

-- Access colors present in 256 colorspace
vim.g.base16_colorspace = 256

local current_theme_name = os.getenv('BASE16_THEME')

if current_theme_name and g.colors_name ~= 'base16-' .. current_theme_name then
  cmd('colorscheme base16-' .. current_theme_name)
end

if is_set_theme_file_readable then
  cmd("source " .. set_theme_path)
end

-- Ensures that lualine is happy.
g.colors_name = current_theme_name
