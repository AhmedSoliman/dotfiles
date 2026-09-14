#!/usr/bin/env zsh

set -eu

# Absolute path to this script's directory, so symlinks don't depend on cwd.
repo="${0:A:h}"

mkdir -p ~/.local/bin ~/.config/sapling ~/Library/Preferences/sapling ~/.config/hunk

conflicts=()

for target in \
  .config/sapling/sapling.conf \
  .config/hunk/config.toml \
  Library/Preferences/sapling/sapling.conf \
  .local/bin/sl-submit-stack; do
  src="$repo/$target"
  dst="$HOME/$target"

  if [ ! -e "$src" ]; then
    echo "Error: missing source $src" >&2
    exit 1
  fi

  if [ -L "$dst" ]; then
    echo "Relinking: $dst"
    ln -sfn "$src" "$dst"
  elif [ -e "$dst" ]; then
    conflicts+=("$target")
  else
    echo "Symlinking: $dst"
    ln -sn "$src" "$dst"
  fi
done

if [ "${#conflicts[@]}" -gt 0 ]; then
  echo "Error: the following exist and are not symlinks:" >&2
  printf '  %s\n' "${conflicts[@]}" >&2
  echo "Move them aside, then re-run this script." >&2
  exit 1
fi
