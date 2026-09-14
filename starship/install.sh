#!/usr/bin/env zsh

set -eu

# Absolute path to this script's directory, so the symlink doesn't depend on cwd.
repo="${0:A:h}"

mkdir -p ~/.config
ln -vsfn "$repo/starship.toml" ~/.config/starship.toml
