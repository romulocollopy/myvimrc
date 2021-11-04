""""""" Plugin management stuff """""""
set nocompatible
filetype off

set rtp+=~/.config/nvim/bundle/Vundle.vim
set rtp+=/usr/local/opt/fzf/bin/fzf

call vundle#begin('~/.config/nvim/bundle')

Plugin 'VundleVim/Vundle.vim'
Plugin 'benekastah/neomake'

" File navigation
Plugin 'kien/ctrlp.vim'
Plugin 'vim-scripts/grep.vim'
Plugin 'majutsushi/tagbar'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'tpope/vim-commentary'

" Status bar mods
Plugin 'bling/vim-airline'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-fugitive'

" HTML / CSS
Plugin 'cakebaker/scss-syntax.vim'
Plugin 'mattn/emmet-vim'
Plugin 'othree/html5.vim'

" JavaScript
Plugin 'pangloss/vim-javascript'

" typescript
Plugin 'HerringtonDarkholme/yats.vim'

" ReactJS
Plugin 'peitalin/vim-jsx-typescript'
Plugin 'maxmellon/vim-jsx-pretty'

" VueJS
Plugin 'posva/vim-vue'

" EmberJS
Plugin 'joukevandermaas/vim-ember-hbs'

" Python
Plugin 'python-mode/python-mode', { 'branch': 'develop', 'for': 'python' }
Plugin 'jmcantrell/vim-virtualenv'
Plugin 'raimon49/requirements.txt.vim', {'for': 'requirements'}
Plugin 'psf/black'
Plugin 'cappyzawa/starlark.vim'

" Rust
Plugin 'rust-lang/rust.vim'
Plugin 'racer-rust/vim-racer'

" Flutter
Plugin 'dart-lang/dart-vim-plugin'
Plugin 'natebosch/vim-lsc'
Plugin 'natebosch/vim-lsc-dart'

" Completion
Plugin  'neoclide/coc.nvim', {'branch': 'release'}
Plugin 'dense-analysis/ale'
" Plugin 'ycm-core/YouCompleteMe'

" ColorScheme
Plugin 'morhetz/gruvbox'

" After all plugins...
call vundle#end()
filetype plugin indent on

"" Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8

" IndentLine
let g:indentLine_enabled = 1
let g:indentLine_concealcursor = 0
let g:indentLine_char = '┆'
let g:indentLine_faster = 1

"" Fix backspace indent
set backspace=indent,eol,start

""""""" General coding stuff """""""
" Always show status bar
set laststatus=2
" Let plugins show effects after 500ms, not 4s
set updatetime=500

" Let vim-gitgutter do its thing on large files
let g:gitgutter_max_signs=10000

augroup FileTypeGroup
  au!
  au BufNewFile,BufRead *.jsx set filetype=javascript.jsx
  au BufNewFile,BufRead *.htm* set filetype=html
  au BufNewFile,BufRead *.rs set filetype=rust
augroup END

augroup python
  au!
  autocmd FileType python,Tiltfile call SetPythonOptions()
  let python_highlight_all = 1
augroup END

augroup rust
  au!
  autocmd FileType rust call SetRustOptions()
augroup END

augroup javascript
  au!
  autocmd FileType js,javascript,javascript.jsx,vue,typescript,css,scss,json call SetJSOptions()
augroup END

augroup html
  au!
  set shiftwidth=2 tabstop=2 softtabstop=2 expandtab autoindent
augroup END

augroup cc
  au!
  autocmd FileType c,cpp set colorcolumn=110
augroup END
"
""""""" Keybindings """""""
" Set up leaders
let mapleader = "\<Space>"
let maplocalleader="\\"


" Neomake and other build commands (etrl-b)
nnoremap <C-b> :w<cr>:Neomake<cr>
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" buffer bindins
map <leader>q  :bp<CR>
map <leader>w  :bn<CR>
map <leader>c  :bdelete<CR>
set hidden

set clipboard+=unnamedplus

" " Copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y
nnoremap  <leader>yy  "+yy

" " Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

vmap < <gv
vmap > >gv

filetype plugin indent on
set grepprg=grep\ -nH\ $*

" ALE

let g:ale_completion_enabled = 1
let g:ale_fix_on_save = 1
let g:ale_html_tidy_options="-e -language en -indent --indent-spaces 2"
let g:ale_javascript_xo_options = "--plug=react --prettier"
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_on_text_changed = 'Always'

let g:ale_fixers = {
\  '*': ['remove_trailing_lines', 'trim_whitespace'],
\  'css': ['eslint'],
\  'html': ['tidy'],
\   'javascript': [
\       'eslint',
\       'prettier',
\       'xo',
\   ],
\  'ruby': ['rubocop'],
\  'rust': ['rustfmt'],
\  'typescript': ['prettier', 'eslint'],
\  'vue': ['eslint', 'prettier', 'vue'],
\}

let g:ale_linters = {
\  'html': ['tidy'],
\  'rust': ['analyzer'],
\  'vue': ['eslint', 'vls'],
\  'javascript': ['xo'],
\}

let g:ale_linter_aliases = {
\  'html': ['tidy'],
\  'ts':['typescript'],
\  'vue': ['vue', 'css', 'javascript'],
\}


set shiftwidth=2 tabstop=2 softtabstop=2 expandtab autoindent

function SetPythonOptions()
  syntax enable
  set colorcolumn=119
  set number showmatch
  set shiftwidth=4 tabstop=4 softtabstop=4
  set completeopt=menuone,noinsert
  nnoremap <leader>l :w<CR> :!isort %<CR> :e<CR> :Black<CR>

  " pymode options
  let g:pymode_options_max_line_length = 120
  let g:pymode_python = 'python3'
  let g:pymode_rope_regenerate_on_write = 1
  let g:pymode_lint_options_pyflakes = { 'builtins': '_' }
  let g:pymode_rope = 1
  let g:pymode_rope_completion = 1
  let g:pymode_rope_completion_bind = 0
  let g:python3_host_prog='/Users/romulo.collopy/.pyenv/versions/3.9.5/bin/python'
  let g:black_virtualenv='/Users/romulo.collopy/.pyenv/versions/3.9.5'
  let g:python_host_prog='/Users/romulo.collopy/.pyenv/versions/2.7.17/bin/python'
  let g:pymode_lint_options_pep8 = {'max_line_length': g:pymode_options_max_line_length}
endfunction

function SetJSOptions()
  syntax enable
  set number showmatch
  setlocal equalprg=js-beautify\ -s2\ --stdin
endfunction

function SetRustOptions()
  " As-you-type autocomplete
  "
  let g:racer_experimental_completer = 1
  set completeopt=menu,menuone,preview,noselect,noinsert
  set colorcolumn=110
  let g:rustfmt_autosave = 1

  let g:ycm_language_server =
  \ [
  \   {
  \     'name': 'rust',
  \     'cmdline': ['rust-analyzer'],
  \     'filetypes': ['rust'],
  \     'project_root_files': ['Cargo.toml']
  \   }
  \ ]

  nnoremap <C-c>g :ALEGoToDefinition<CR>
  nnoremap K :ALEHover<CR>

  nmap gd         <Plug>(rust-def)
  nmap gs         <Plug>(rust-def-split)
  nmap gx         <Plug>(rust-def-vertical)
  nmap gt         <Plug>(rust-def-tab)
  nmap <leader>gd <Plug>(rust-doc)
  nmap <leader>gD <Plug>(rust-doc-tab)
  set shiftwidth=4 tabstop=4 softtabstop=4 expandtab autoindent
endfunction

" Fugitive Git
set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)\
if exists("*fugitive#statusline")
  set statusline+=%{fugitive#statusline()}
endif

nmap <F8> :TagbarToggle<CR>
"
"" Tabs
nnoremap <Tab> gt
nnoremap <S-Tab> gT
nnoremap <silent> <S-t> :tabnew<CR>

map <C-n> :NERDTreeToggle<CR>
let g:NERDTreeIgnore=['\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__']
let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']

set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite,venv,node_modules,.venv,target

" ripgrep
if executable('rg')
  let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
  set grepprg=rg\ --vimgrep
  command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
endif

" grep.vim
nnoremap <silent> <leader>f :Rgrep<CR>
let Grep_Default_Options = '-IR'
let Grep_Skip_Files = '*.log *.db'
let Grep_Skip_Dirs = '.git node_modules venv .venv'

colorscheme gruvbox
