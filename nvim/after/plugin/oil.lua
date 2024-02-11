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
  keymaps = {
    ["<C-s>"] = "actions.select_vsplit",
    ["<C-v>"] = "actions.select_split",
    ["q"] = "actions.close",
    ["p"] = "actions.parent",
    ["-"] = "actions.open_cwd",
    ["_"] = "actions.parent",
    ["<C-p>"] = false,
  },
  skip_confirm_for_simple_edits = true,

})
