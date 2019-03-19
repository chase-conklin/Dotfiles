syntax enable

" ==================
"
" Plugins
"
" ==================

call plug#begin('~/.vim/plugged')
Plug 'sjl/gundo.vim'
Plug 'scrooloose/nerdtree'
Plug 'yggdroot/indentLine'
Plug 'stanangeloff/php.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'
Plug 'edkolev/tmuxline.vim'
Plug 'mattn/emmet-vim'
Plug 'vim-syntastic/syntastic'
Plug 'lumiliet/vim-twig'
Plug 'mileszs/ack.vim'
Plug 'airblade/vim-gitgutter'
call plug#end()

" =================
"
" General Settings
"
" =================

" Set tab settings
set tabstop=2
set softtabstop=2
set expandtab
set backspace=indent,eol,start

" Set Leader
let mapleader=","

" =================
"
" UI Config
"
" =================

set number
set relativenumber
set showcmd
set wildmenu
set showmatch
set noshowmode

" Searching
set incsearch
set hlsearch
nnoremap <leader><space> :nohlsearch<CR>

" Folding
set foldenable
set foldlevelstart=10
set foldnestmax=10
nnoremap <space> za
set foldmethod=indent

" Movement
nnoremap j gj
nnoremap k gk
nnoremap 0 g0
nnoremap $ g$
nnoremap gV `[v`]

" Split Navigation
nnoremap <C-h> <C-W><C-H>
nnoremap <C-j> <C-W><C-J>
nnoremap <C-k> <C-W><C-K>
nnoremap <C-l> <C-W><C-L>

" ==================
"
" Plugin Settings
"
" ==================

" IndentLine Settings
let g:indentLine_char='|'

" CtrlP and Ack Settings
cnoreabbrev Ack Ack!
nnoremap <leader>a :Ack!<Space>
if executable ('ag')
  let g:ctrlp_user_command = 'fd . -t file'
  let g:ackprg = 'ag --vimgrep'
endif

"NerdTree Settings
map <C-n> :NERDTreeToggle<CR>

" Gundo Settings
nnoremap <leader>u :GundoToggle<CR>
let g:gundo_prefer_python3 = 1

"Airline Settings
let g:airline_powerline_fonts = 1
let g:airline_theme='luna'
let g:airline#extensions#hunks#enabled=1

