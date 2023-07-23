local actions = require('fzf-lua.actions')

require('fzf-lua').setup({
  "telescope",
  -- OR  "max-perf",
  fzf_opts = {
    ['--layout'] = false,
  },
  files = {
    actions = {
      ['default'] = actions.file_edit_or_qf,
      ['ctrl-x'] = actions.file_split,
      ['ctrl-v'] = actions.file_vsplit,
      ['ctrl-t'] = actions.file_tabedit,
      ['alt-q'] = actions.file_sel_to_qf,
    },
    -- fd_opts = "--color=never --ignore-file .gitignore --type f --hidden --follow --exclude .git --exclude .sl --exclude node_modules",
    --    file_icons = false,
    --    git_icons = false,
  },
  --  git = {
  --    file_icons = false,
  --    git_icons = false,
  --  },
  grep = {
    rg_glob = true,
--    rg_opts = "--ignore-file=.gitignore --hidden --column --line-number --no-heading " ..
--              "--color=always --smart-case -g '!{.git,node_modules,.sl}/*'",
--    file_icons = false,
--    git_icons = false,
  },
  winopts = {
    preview = {
      layout = 'vertical',
    },
  },
})
