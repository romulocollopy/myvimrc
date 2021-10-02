""""""" Plugin management stuff """""""
set nocompatible
filetype off

set rtp+=~/.config/nvim/bundle/Vundle.vim
call vundle#begin('~/.config/nvim/bundle')

Plugin 'VundleVim/Vundle.vim'

" Custom plugins...
" Ctrl-P - Fuzzy file search
Plugin 'kien/ctrlp.vim'
" Neomake build tool (mapped below to <c-b>)
Plugin 'benekastah/neomake'
" Remove extraneous whitespace when edit mode is exited
Plugin 'thirtythreeforty/lessspace.vim'

Plugin 'majutsushi/tagbar'
Plugin 'ycm-core/YouCompleteMe'

" Status bar mods
Plugin 'bling/vim-airline'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-fugitive'

Plugin 'martinda/Jenkinsfile-vim-syntax'

" Tab completion
Plugin 'ervandew/supertab'

" HTML / CSS
Plugin 'hail2u/vim-css3-syntax'
Plugin 'cakebaker/scss-syntax.vim'
Plugin 'mattn/emmet-vim'
Plugin 'othree/html5.vim'

" JavaScript
Plugin 'jelera/vim-javascript-syntax'
" vue
Plugin 'posva/vim-vue'

" ember
Plugin 'joukevandermaas/vim-ember-hbs'

" typescript
Plugin 'leafgarland/typescript-vim'
Plugin 'HerringtonDarkholme/yats.vim'

Plugin 'dense-analysis/ale'

" Python
Plugin 'python-mode/python-mode' ", { 'branch': 'develop', 'for': 'python' }
Plugin 'jmcantrell/vim-virtualenv'
Plugin 'raimon49/requirements.txt.vim', {'for': 'requirements'}
Plugin 'psf/black'

Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'vim-scripts/grep.vim'
Plugin 'tpope/vim-commentary'
Plugin 'cappyzawa/starlark.vim'

" Rust
Plugin 'rust-lang/rust.vim'
Plugin 'racer-rust/vim-racer'

Plugin 'vim-ruby/vim-rubyv'

" ColorScheme
Plugin 'morhetz/gruvbox'
"
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


""""""" SuperTab configuration """""""
"let g:SuperTabDefaultCompletionType = "<c-x><c-u>"
function! Completefunc(findstart, base)
    return "\<c-x>\<c-p>"
endfunction

"call SuperTabChain(Completefunc, '<c-n>')

"let g:SuperTabCompletionContexts = ['g:ContextText2']


""""""" General coding stuff """""""
" Always show status bar
set laststatus=2
" Let plugins show effects after 500ms, not 4s
set updatetime=500
" Disable mouse click to go to position
set mouse-=a

" Let vim-gitgutter do its thing on large files
let g:gitgutter_max_signs=10000

augroup python
  au!
  autocmd FileType python,Tiltfile call SetPythonOptions()
augroup END

augroup rust
  au!
  autocmd BufNewFile,BufRead *.rs set filetype=rust
  autocmd FileType rust call SetRustOptions()
augroup END

augroup javascript
  au!
  autocmd FileType js,javascript,vue,typescript,css,scss,json call SetJSOptions()
augroup END

augroup css html
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


" Neomake and other build commands (ctrl-b)
nnoremap <C-b> :w<cr>:Neomake<cr>
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" buffer bindins
map <leader>q  :bp<CR>
map <leader>w  :bn<CR>
map <leader>c  :bdelete<CR>
set hidden

autocmd BufNewFile,BufRead *.tex,*.bib noremap <buffer> <C-b> :w<cr>:new<bar>r !make<cr>:setlocal buftype=nofile<cr>:setlocal bufhidden=hide<cr>:setlocal noswapfile<cr>
autocmd BufNewFile,BufRead *.tex,*.bib imap <buffer> <C-b> <Esc><C-b>

set rtp+=/usr/local/opt/fz

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
let g:tex_flavor = "latex"

let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['prettier', 'eslint'],
\   'typescript': ['prettier', 'eslint'],
\   'css': ['eslint'],
\   'vue': ['eslint'],
\   'ruby': ['rubocop'],
\   'rust': ['rustfmt', 'trim_whitespace', 'remove_trailing_lines']
\}

let g:ale_linters = {
\  'rust': ['analyzer'],
\  'vue': ['eslint', 'vls']
\}

let g:ale_linter_aliases = {'vue': ['vue', 'javascript'], 'js': ['javascript'], 'ts':['typescript']}
" let g:vue_pre_processors = ['scss']

let g:ale_fix_on_save = 1
" let g:ale_lint_on_insert_leave = 1
let g:ale_lint_on_text_changed = 'Always'


function SetPythonOptions()
  syntax enable
  set colorcolumn=119
  set number showmatch
  set shiftwidth=4 tabstop=4 softtabstop=4 expandtab autoindent
  set completeopt=menuone,noinsert

  let python_highlight_all = 1
  let g:pymode_python = 'python3'
  let g:pymode_options_max_line_length = 119
  let g:pymode_lint_options_pep8 =
    \ {'max_line_length': g:pymode_options_max_line_length}

  let g:pymode_lint_options_pyflakes = { 'builtins': '_' }
  let g:python3_host_prog='/Users/romulo.collopy/.pyenv/versions/3.9.1/bin/python'
  let g:python_host_prog='/Users/romulo.collopy/.pyenv/versions/2.7.17/bin/python'
  let g:pymode_rope = 1

  nnoremap <leader>l :w<CR> :!isort %<CR> :e<CR> :Black<CR>

endfunction

function SetJSOptions()
  syntax enable
  set number showmatch
  set shiftwidth=2 tabstop=2 softtabstop=2 expandtab autoindent
  setlocal equalprg=js-beautify\ -s2\ --stdin
endfunction

function SetRustOptions()
  " As-you-type autocomplete
  "
  let g:racer_experimental_completer = 1
  set completeopt=menu,menuone,preview,noselect,noinsert
  set colorcolumn=110
  let g:ale_completion_enabled = 1
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
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite,venv,node_modules

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
