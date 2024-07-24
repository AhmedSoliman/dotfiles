local g = vim.g
local cmd = vim.cmd
local fn = vim.fn
local set_theme_path = "$HOME/.config/tinted-theming/set_theme.lua"
local is_set_theme_file_readable = fn.filereadable(fn.expand(set_theme_path)) == 1 and true or false

-- Access colors present in 256 colorspace
vim.g.base16_colorspace = 256

local current_theme_name = os.getenv('BASE16_THEME')

-- temporarily disabled
-- if current_theme_name and g.colors_name ~= 'base16-' .. current_theme_name then
--  cmd('colorscheme base16-' .. current_theme_name)
-- end

-- if is_set_theme_file_readable then
--  cmd("source " .. set_theme_path)
-- end

-- Ensures that lualine is happy.
g.colors_name = current_theme_name


-- override and always use rose-pine for now until tinted-theming is 0.10 comptible
--
require("rose-pine").setup({
  variant = "moon",        -- auto, main, moon, or dawn
  dark_variant = "moon",   -- main, moon, or dawn
  dim_inactive_windows = true,
  extend_background_behind_borders = true,

  enable = {
    terminal = true,
    legacy_highlights = true,     -- Improve compatibility for previous versions of Neovim
    migrations = true,            -- Handle deprecated options automatically
  },

  styles = {
    bold = true,
    italic = true,
    transparency = false,
  },

  groups = {
    border = "muted",
    link = "iris",
    panel = "surface",

    error = "love",
    hint = "iris",
    info = "foam",
    note = "pine",
    todo = "rose",
    warn = "gold",

    git_add = "foam",
    git_change = "rose",
    git_delete = "love",
    git_dirty = "rose",
    git_ignore = "muted",
    git_merge = "iris",
    git_rename = "pine",
    git_stage = "iris",
    git_text = "rose",
    git_untracked = "subtle",

    h1 = "iris",
    h2 = "foam",
    h3 = "rose",
    h4 = "gold",
    h5 = "pine",
    h6 = "foam",
  },

  highlight_groups = {
    -- Comment = { fg = "foam" },
    -- VertSplit = { fg = "muted", bg = "muted" },
  },

  before_highlight = function(group, highlight, palette)
    -- Disable all undercurls
    -- if highlight.undercurl then
    --     highlight.undercurl = false
    -- end
    --
    -- Change palette colour
    -- if highlight.fg == palette.pine then
    --     highlight.fg = palette.foam
    -- end
  end,
})

vim.cmd("colorscheme rose-pine")
