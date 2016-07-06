set shell=/bin/bash

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

" plugin on GitHub repo
Plugin 'altercation/vim-colors-solarized'
Plugin 'mmai/vim-zenmode'

Plugin 'sickill/vim-monokai'
Plugin 'tmhedberg/SimpylFold'
Plugin 'ternjs/tern_for_vim'

Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'

Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-commentary'
Plugin 'ntpeters/vim-better-whitespace'

Plugin 'sheerun/vim-polyglot'

Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'vim-scripts/grep.vim'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/syntastic'
Plugin 'nvie/vim-flake8'
Plugin 'jmcantrell/vim-virtualenv'
Plugin 'python-rope/ropevim'

Plugin 'othree/html5.vim'
Plugin 'ekalinin/Dockerfile.vim'
Plugin 'lepture/vim-jinja'
Plugin 'mattn/emmet-vim'

"C supoort
Plugin 'vim-scripts/c.vim'

" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'

" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'

" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}

call vundle#end()            " required
filetype plugin indent on    " required

set encoding=utf-8
let mapleader = "\<Space>"

" Vim Airline
let g:airline_theme = 'powerlineish'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#whitespace#enabled = 1
let g:airline#extensions#virtualenv#enabled = 1

let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tagbar#enabled = 1
let g:airline_powerline_fonts = 1

" Fugitive Git
set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)\
if exists("*fugitive#statusline")
  set statusline+=%{fugitive#statusline()}
endif

set diffopt=filler,context:4,vertical

" SimpleFold
autocmd BufWinEnter *.py setlocal foldexpr=SimpylFold(v:lnum) foldmethod=expr
autocmd BufWinLeave *.py setlocal foldexpr< foldmethod<
let g:SimpylFold_docstring_preview = 1
let g:SimpylFold_fold_docstring = 0
let g:SimpylFold_fold_import = 0

" YouCompleteMe
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_register_as_syntastic_checker = 0
let g:ycm_seed_identifiers_with_syntax = 1 "Feed YCM identifier with syntax keywords
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>


" Syntastic options
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Ctlp bindings
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

set wildmode=list:longest,list:full
set wildignore=*/tmp/*,*.so,*.swp,*.zip,*.o,*.obj,.git,*.rbc,*.pyc,__pycache__
let g:ctrlp_custom_ignore = '\v[\/](node_modules|target|dist)|(\.(swp|tox|ico|git|hg|svn))$'
let g:ctrlp_user_command = "find %s -type f | grep -Ev '"+ g:ctrlp_custom_ignore +"'"
let g:ctrlp_use_caching = 1

"Vim-grep
map <leader>f :Rgrep<CR>

" NERDTree bindings
let NERDTreeIgnore=['\.pyc$', '\~$', '__pycache__'] "ignore files in NERDTree
let NERDTreeChDirMode = 2
let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
map <leader>n  :NERDTreeToggle<CR>

" buffer bindins
map <leader>q  :bp<CR>
map <leader>w  :bn<CR>
map <leader>c  :bdelete<CR>
set hidden

"Zenmode
let g:zenmode_background = "dark"
let g:zenmode_colorscheme = "monokai"

" -- solarized personal conf
let g:solarized_termcolors=256

if $COLORTERM == 'gnome-terminal'
    set term=gnome-256color
endif

try
    colorscheme monokai
catch
endtry
set background=dark

" YouCompleteMe
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

" enable syntax highlighting
syntax enable

" show line numbers
set number

" set tabs to have 4 spaces
set ts=4

" indent when moving to the next line while writing code
set autoindent

" expand tabs into spaces
set expandtab

" when using the >> or << commands, shift lines by 4 spaces
set shiftwidth=4

" show a visual line under the cursor's current line
set cursorline

" show the matching part of the pair for [] {} and ()
set showmatch

" enable all Python syntax highlighting features
let python_highlight_all = 1

" Directories for swp files
set nobackup
set noswapfile

vmap < <gv
vmap > >gv
" set guifont=Source\ Code\ Pro\ for\ Powerline:h12
set linespace=2

au FileType python  map <buffer> <leader>b oimport ipdb; ipdb.set_trace()<esc>
au FileType python  map <buffer> <silent> <leader>B Oimport ipdb; ipdb.set_trace()<esc>
