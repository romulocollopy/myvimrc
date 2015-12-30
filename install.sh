#!/bin/bash

$PWD = `pwd`

#Link .vimrc to reps file
ln -s `pwd`/vimrc ~/.vimrc

# Install Vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Install Vundle Plugins
vim +PluginInstall +qall

# Install cmake to compile YouCompleteMe
sudo pacman -S cmake --noconfirm

# Build youCompleteMe
mkdir ~/ycm_build; cd ~/ycm_build
cmake -G "Unix Makefiles" . ~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp
cmake --build . --target ycm_support_libs
cd $PWD
rm -rf ~/ycm_build
