#!/bin/bash

ln -vfs ~/.dotfiles/nvim ~/.config/nvim

mkdir -p ~/.vim-tmp

git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim
