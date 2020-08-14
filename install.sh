#!/bin/bash

if [!hash npm 2> /dev/null]; then
    sudo pacman -S nodejs npm --noconfirm
fi

if [!hash cmake> /dev/null]; then
    sudo pacman -S cmake --noconfirm
fi

$PWD = `pwd`

#Link .vimrc to reps file
ln -s `pwd`/vimrc ~/.vimrc
ln -s `pwd`/myvimrc/nvim/init.vim `pwd`/.config/nvim/init.vim

# Install Vundle
git clone https://github.com/VundleVim/Vundle.vim.git `pwd`/.config/nvim/bundle/Vundle.vim
# Install Vundle Plugins
vim +PluginInstall +qall

pyenv exec python3 install rope black pynvim
pyenv exec python2 install rope black pynvim

# Install cmake to compile YouCompleteMe
if [!hash cmake 2> /dev/null]; then
    sudo pacman -S cmake --noconfirm
fi
# Build youCompleteMe
cd ~/.vim/bundle/YouCompleteMe;
if hash go 2> /dev/null; then
    python install.py --clang-completer --gocode-completer --tern-completer
else
    python install.py --clang-completer --tern-completer
fi

# C configs
ln -s --force `pwd`/ycm_extra_conf.py ~/.vim/.ycm_extra_conf.py

# tern_js dependencies
cd ~/.config/nvim/bundle/tern_for_vim; npm install
