syntax enable  				" enable syntax processing
" Spaces & Tabs
set tabstop=2  	            " number of visual spaces per TAB
set softtabstop=2           " number of spaces in tab when editing
set expandtab               " tabs are spaces
set backspace=indent,eol,start " backspace through anything in insert mode
" UI Config
set number                  " show line numbers
set relativenumber          " show number lines relative to the cursor
set showcmd                 " show command in bottom bar
set wildmenu                " visual autocomplete for command menu
set showmatch               " highlight matching [{()}]
set noshowmode
let g:indentLine_char='|'
" Searching
set incsearch               " search as characters are entered
set hlsearch                " highlight matches
" Folding
set foldenable              " enable folding
set foldlevelstart=10       " open most folds by default
set foldnestmax=10          " 10 nested fold max
nnoremap <space> za         " space open/closes folds
set foldmethod=indent       " fold based on indent level
" Movement
" move vertically by visual line
nnoremap j gj
nnoremap k gk
nnoremap 0 g0
nnoremap $ g$
nnoremap gV `[v`]           " highlight last inserted text
" Leader Shortcuts
" leader is comma
let mapleader=","
nnoremap <leader><space> :nohlsearch<CR>
" turn off search highlight
nnoremap <leader>u :GundoToggle<CR>  "toggle gundo
" Plugin Remapping
map <C-n> :NERDTreeToggle<CR> " toggle nerd tree
cnoreabbrev Ack Ack!
nnoremap <Leader>a :Ack!<Space>
" Plugins
if executable ('ag')
  let g:ctrlp_user_command = 'fd . -t file'
  let g:ackprg = 'ag --vimgrep'
endif
let g:gundo_prefer_python3 = 1
let g:airline_powerline_fonts = 1
let g:airline_theme='luna'
let g:airline#extensions#hunks#enabled=1
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
call plug#end()
