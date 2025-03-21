local trouble = require("trouble")
local symbols = trouble.statusline({
  mode = "lsp_document_symbols",
  groups = {},
  title = false,
  filter = { range = true },
  format = "{kind_icon}{symbol.name:Normal}",
  -- The following line is needed to fix the background color
  -- Set it to the lualine section you want to use
  hl_group = "lualine_c_normal",
})

-- table.insert(opts.sections.lualine_c, {
--   symbols.get,
--   cond = symbols.has,
-- })

require('lualine').setup({
  extensions = { 'oil' },
  options = {
    icons_enabled = true,
    theme = 'auto',
    -- component_separators = '|',
    component_separators = { left = '', right = '' },
    -- section_separators = ',',
    section_separators = { left = '', right = '' },
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
        color_correction = nil, -- Can be nil, "static" or "dynamic". This option is useful only when you have highlights enabled.
        -- Many colorschemes don't define same backgroud for nvim-navic as their lualine statusline backgroud.
        -- Setting it to "static" will perform a adjustment once when the component is being setup. This should
        --   be enough when the lualine section isn't changing colors based on the mode.
        -- Setting it to "dynamic" will keep updating the highlights according to the current modes colors for
        --   the current section.
      }
    }
  }
})
