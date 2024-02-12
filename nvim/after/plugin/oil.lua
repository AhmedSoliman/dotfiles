require("oil").setup({
  view_options = {
    show_hidden = true,
  },
  columns = {
    "icon",
    --"permissions",
    --"size",
    --"mtime",
  },
  float = {
    max_width = 80,
    max_height = 60,
  },
  keymaps = {
    ["<C-v>"] = "actions.select_vsplit",
    ["<C-s>"] = "actions.select_split",
    ["q"] = "actions.close",
    ["p"] = "actions.parent",
    ["-"] = "actions.open_cwd",
    ["_"] = "actions.parent",
    ["<C-p>"] = false,
  },
  skip_confirm_for_simple_edits = true,

})
