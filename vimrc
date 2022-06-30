syntax enable

" ==================
"
" Plugins
"
" ==================

" Install vim-plug if not found
let data_dir = '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source '~/.vimrc'
endif

call plug#begin('~/.vim/plugged')

" Utilities
Plug 'sjl/gundo.vim'
Plug 'scrooloose/nerdtree'
Plug 'yggdroot/indentLine'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'edkolev/tmuxline.vim'
Plug 'mattn/emmet-vim'
Plug 'mhinz/vim-signify'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

" Syntax & Language
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'lumiliet/vim-twig'
Plug 'stanangeloff/php.vim'
Plug 'vim-syntastic/syntastic'

" Themes
Plug 'dracula/vim', { 'as': 'dracula' }

call plug#end()

" =================
"
" General Settings
"
" =================

" Set tab settings
set expandtab
set shiftwidth=2
set softtabstop=2
set smartindent
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

"NerdTree Settings
map <C-n> :NERDTreeToggle<CR>

" Fzf Settings
nnoremap <leader>f :Files<CR>
nnoremap <leader>a :Ag<CR>
nnoremap <leader>r :Rg<CR>
" Opens fzf search in window overlay
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
" Add custom Rg and Files commands
command! -bang -nargs=* Rg 
    \ call fzf#vim#grep('rg --no-ignore --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --glob "!node_modules/*" --glob "!bower_components/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)

" Signify Settings
let g:signify_vcs_list = [ 'git' ]
highlight SignColumn ctermbg=NONE cterm=NONE guibg=NONE gui=NONE
highlight SignifySignAdd cterm=bold ctermbg=none ctermfg=10
highlight SignifySignDelete cterm=bold ctermbg=none  ctermfg=9
highlight SignifySignChange cterm=bold ctermbg=none ctermfg=11

" Gundo Settings
nnoremap <leader>u :GundoToggle<CR>
let g:gundo_prefer_python3 = 1

"Airline Settings
let g:airline_powerline_fonts = 1
let g:airline_theme='dracula'
let g:airline#extensions#hunks#enabled=1

" Syntastic Settings
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
