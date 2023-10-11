require("telescope").setup {
  defaults = vim.tbl_extend(
    "force",
    require('telescope.themes').get_ivy(), -- or get_cursor, get_ivy
    {
      --- your own `default` options go here, e.g.:
      path_display = {
        truncate = 2
      },
      mappings = {
        -- i = {
        --   ["<esc>"] = actions.close,
        -- },
      }
    }
  ),
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {
        -- even more opts
      }

      -- pseudo code / specification for writing custom displays, like the one
      -- for "codeactions"
      -- specific_opts = {
      --   [kind] = {
      --     make_indexed = function(items) -> indexed_items, width,
      --     make_displayer = function(widths) -> displayer
      --     make_display = function(displayer) -> function(e)
      --     make_ordinal = function(e) -> string
      --   },
      --   -- for example to disable the custom builtin "codeactions" display
      --      do the following
      --   codeactions = false,
      -- }
    },
    fzf = {
      fuzzy = true
    }
  }
}
-- To get ui-select loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require("telescope").load_extension("ui-select")
require("telescope").load_extension("fzf")
require("telescope").load_extension("dap")

-- local builtin = require('telescope.builtin')
-- local utils = require('telescope.utils')
-- local themes = require('telescope.themes')

--vim.keymap.set('n', '<C-p>', builtin.git_files, {})
-- vim.keymap.set('n', '<C-p>', function()
--   local _, ret, _ = utils.get_os_command_output({ 'git', 'rev-parse', '--is-inside-work-tree' })
--   if ret == 0 then
--     builtin.git_files(themes.get_ivy({}))
--   else
--     builtin.find_files(themes.get_ivy({}))
--   end
-- end, { noremap = true })
--
--
-- -- vim.keymap.set('n', '<C-p>', builtin.find_files, {})
-- vim.keymap.set('n', '<leader>a', vim.lsp.buf.code_action, {})
-- vim.keymap.set('n', '<leader>r', builtin.resume, {})
-- vim.keymap.set('n', '<leader>f', builtin.live_grep, {})
-- vim.keymap.set('n', '<leader>F', builtin.grep_string, {})
-- vim.keymap.set('n', '<C-b>', builtin.buffers, {})
-- --vim.keymap.set('n', '<leader>s', builtin.lsp_workspace_symbols, {})
-- vim.keymap.set('n', '<leader>s', builtin.lsp_dynamic_workspace_symbols, {})
