#!/bin/bash
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew update

# native MacOs Python sucks
brew rm python

# native vim is old, MacVim is required to YCM
brew uninstall --force macvim vim

# cmake compiles YCM, npm and nodejs to support JS in YCM
brew install python python3 cmake flake npm nodejs

# this makes MacVim aware of brew's Python
export PATH=/usr/local/bin:/usr/local/sbin:$PATH

brew install macvim --override-system-vim --custom-icons --with-cscope --with-lua --enable-pythoninterp --enable-python3interp --ovrride-system-vi
brew linkapps macvim

ln -s /usr/local/Cellar/macvim/7.4-101/bin/mvim /usr/local/bin/mvim

sudo pip install virtualenv virtualenvwrapper flake8 rope ropemode ropevim
echo "source /usr/local/bin/virtualenvwrapper.sh" >> ~/.profile

$PWD = `pwd`

#Link .vimrc to reps file
ln -s `pwd`/vimrc ~/.vimrc

# if you uses nvim
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
# In MAcVim, you'll need to manually change your fount in Edit menu
git clone https://github.com/powerline/fonts.git ~/vim_airline_fonts
~/vim_airline_fonts/install.sh
rm -rf ~/vim_airline_fonts
