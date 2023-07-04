#!/bin/bash


mkdir -p ~/.tmux
ln -s ~/.dotfiles/tmux/tmux.conf ~/.tmux.conf
ln -s ~/.dotfiles/tmux/tmux-status.conf ~/.tmux/tmux-status.conf

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
git clone https://github.com/tinted-theming/base16-fzf.git ~/.config/tinted-theming/base16-fzf
