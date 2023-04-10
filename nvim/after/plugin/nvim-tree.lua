-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

local lib = require("nvim-tree.lib")
local view = require("nvim-tree.view")


local function collapse_all()
  require("nvim-tree.actions.tree-modifiers.collapse-all").fn()
end

local function edit_or_open()
  -- open as vsplit on current node
  local action = "edit"
  local node = lib.get_node_at_cursor()

  -- Just copy what's done normally with vsplit
  if node.link_to and not node.nodes then
    require('nvim-tree.actions.node.open-file').fn(action, node.link_to)
    view.close() -- Close the tree if file was opened

  elseif node.nodes ~= nil then
    lib.expand_or_collapse(node)

  else
    require('nvim-tree.actions.node.open-file').fn(action, node.absolute_path)
    view.close() -- Close the tree if file was opened
  end

end

local function vsplit_preview()
  -- open as vsplit on current node
  local action = "vsplit"
  local node = lib.get_node_at_cursor()

  -- Just copy what's done normally with vsplit
  if node.link_to and not node.nodes then
    require('nvim-tree.actions.node.open-file').fn(action, node.link_to)

  elseif node.nodes ~= nil then
    lib.expand_or_collapse(node)

  else
    require('nvim-tree.actions.node.open-file').fn(action, node.absolute_path)

  end

  -- Finally refocus on tree if it was lost
  view.focus()
end

local function custom_callback(callback_name)
  return string.format(":lua require('treeutils').%s()<CR>", callback_name)
end

local config = {
  sort_by = "case_sensitive",
  open_on_setup = true,
  -- ignore_buffer_on_setup = true,
  view = {
    adaptive_size = true,
    mappings = {
      custom_only = false,
      list = {
        { key = "u", action = "dir_up" },
        { key = "n", action = "create" },
        { key = "r", action = "full_rename" },
        { key = "s", action = "vsplit" },
        { key = "L", action = "vsplit_preview", action_cb = vsplit_preview },
        { key = "h", action = "close_node" },
        { key = "H", action = "collapse_all", action_cb = collapse_all },
        { key = "<c-f>", cb = custom_callback "launch_find_files" },
        { key = "<leader>f", cb = custom_callback "launch_live_grep" },
      },
    },
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = false,
  },
}

vim.api.nvim_set_keymap("n", "<C-n>", ":NvimTreeToggle<cr>", { silent = true, noremap = true })

require("nvim-tree").setup(config)
