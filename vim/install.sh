#!/bin/bash

mkdir -p ~/.vim/bundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
ln -s ~/.dotfiles/vim/plugins.vim ~/.vim/plugins.vim
ln -s ~/.dotfiles/vim/after ~/.vim/after
ln -s ~/.dotfiles/vim/vimrc ~/.vimrc
