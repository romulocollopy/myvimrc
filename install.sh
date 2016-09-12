#!/bin/bash

if [!hash pip 2> /dev/null]; then
    sudo pacman -S python2-pip python-pip --noconfirm
fi

if [!hash npm 2> /dev/null]; then
    sudo pacman -S nodejs npm --noconfirm
fi

$PWD = `pwd`

#Link .vimrc to reps file
ln -s `pwd`/vimrc ~/.vimrc

# Install Vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
# Install Vundle Plugins
vim +PluginInstall +qall
sudo pip install rope
cd ~/.vim/bundle/ropevim/;sudo python setup.py install

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

#Install Airline fonts
git clone https://github.com/powerline/fonts.git ~/vim_airline_fonts
cd ~/vim_airline_fonts
./install.sh
cd ~
rm -rf ~/vim_airline_fonts

#Install falke8 systax checker
sudo pacman -S flake8 --noconfirm
