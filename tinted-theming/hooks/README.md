# tinted-shell hooks (patched)

Copy of `hooks/*.sh` from [tinted-shell](https://github.com/tinted-theming/tinted-shell) at `9359c5d`,
used via `BASE16_SHELL_HOOKS_PATH` (set in `zsh/runcoms/zshrc`). Two upstream bugs from the POSIX
port (#66/#69) are fixed:

- `base16-tmux.sh`: writes `set -g @100colors-base16` (the old `echo -e "\0100colors"` octal escape for
  `@` was translated literally), which tinted-tmux ignores. Fixed to `@colors-base16`.
- `base16-fzf.sh`: looks for `sh/base16-<theme>.config`, but tinted-fzf ships `sh/base16-<theme>.sh`.
  Fixed to source the `.sh` file.

Hooks only run if executable. Delete this directory and the `BASE16_SHELL_HOOKS_PATH` line once
upstream is fixed.
