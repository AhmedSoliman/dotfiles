require('lualine').setup({
  extensions = { 'nvim-tree' },
  options = {
    icons_enabled = false,
    theme = 'auto',
    component_separators = '|',
    section_separators = ',',
  },
  sections = {
    lualine_c = {
      {
        "filename",
        file_status = true, -- displays file status (readonly, modified, etc.)
        path = 1,           -- 0 filename, 1 relative path, 2 absolute path.
      },
    },
  },
  winbar = {
    lualine_c = {
      {
        "navic",
        -- Component specific options
        color_correction = nil,    -- Can be nil, "static" or "dynamic". This option is useful only when you have highlights enabled.
        -- Many colorschemes don't define same backgroud for nvim-navic as their lualine statusline backgroud.
        -- Setting it to "static" will perform a adjustment once when the component is being setup. This should
        --   be enough when the lualine section isn't changing colors based on the mode.
        -- Setting it to "dynamic" will keep updating the highlights according to the current modes colors for
        --   the current section.
      }
    }
  }
})
