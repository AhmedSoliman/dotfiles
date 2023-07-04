#!/usr/bin/env zsh

set -vx

git clone  https://github.com/tinted-theming/base16-shell.git ~/.config/base16-shell

git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

setopt EXTENDED_GLOB

# Install configuration
for rcfile in "${ZDOTDIR:-$HOME}"/.dotfiles/zsh/runcoms/^README.md(.N); do
    ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done

# Set default shell
chsh -s /bin/zsh

# Set theme
base16_rose-pine-moon
