#!/bin/bash
# /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
# brew update
brew rm vim python macvim
brew install python python3 cmake flake npm nodejs
export PATH=/usr/local/bin:/usr/local/sbin:$PATH

brew uninstall --force macvim vim
brew install macvim --override-system-vim --custom-icons --with-cscope --with-lua --enable-pythoninterp --enable-python3interp --ovrride-system-vi --with-python --with-python3
brew linkapps macvim
sudo ln -sf /usr/local/bin/mvim vim

sudo pip install virtualenv virtualenvwrapper rope flake8
# echo "source /usr/local/bin/virtualenvwrapper.sh" >> ~/.profile

$PWD = `pwd`

#Link .vimrc to reps file
ln -s `pwd`/vimrc ~/.vimrc
ln -s ~/.vimrc ~/.nvimrc
ln -s ~/.vim ~/.nvim

# Install Vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
# Install Vundle Plugins
vim +PluginInstall +qall
python ~/.vim/bundle/ropevim/setup.py install

# Build youCompleteMe
python ~/.vim/bundle/YouCompleteMe/install.py --clang-completer --tern-completer

#Install Airline fonts
git clone https://github.com/powerline/fonts.git ~/vim_airline_fonts
~/vim_airline_fonts/install.sh
rm -rf ~/vim_airline_fonts
