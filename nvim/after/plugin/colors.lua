require('rose-pine').setup({
  -- disable_background = true,
  variant = "auto",
  dark_variant = "main",
  --dark_variant = "dawn",
  disable_float_background = false,
  disable_background = false,
  dim_nc_background = true,
  bold_vert_split = true,
})

function ColorMyPencils(color)
  color = color or "rose-pine"
  --color = color or "iceberg"
  vim.cmd.colorscheme(color)

--  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
--  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
--
end

ColorMyPencils()
