" Now GVIM 8.0+ / Python focused

" Clear
set nocompatible
filetype off

" Auto-install plugin manager if it doesnt exist (and PlugInstall)
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

" TODO: Disabled plugins
" Plug 'kien/ctrlp.vim'              " Search based navigation
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
" Plug 'junegunn/fzf.vim'
" Plug 'sjl/gundo.vim'
" Plug 'scrooloose/syntastic'      " Syntax Checker


" List of active plugins
call plug#begin('~/.vim/plugged')

" GUI plugins
Plug 'scrooloose/nerdtree'          " Tree based file browser (ctrl-f)
Plug 'nanotech/jellybeans.vim'      " Dark colourscheme
Plug 'tpope/vim-eunuch'             " for :SudoWrite :Rename
Plug 'itchyny/lightline.vim'        " Status line
Plug 'taohex/lightline-buffer'      " Buffer navigate

" Git Integration
Plug 'tpope/vim-fugitive'

" Navigation
Plug 'easymotion/vim-easymotion'    " hilights your motions with \\
Plug 'justinmk/vim-sneak'           " Sneak to character pair with s/z{ab}

" Code Operations
Plug 'b4winckler/vim-angry'         " Navigate comma separated arguments
Plug 'tommcdo/vim-lion'             " align characters gl, gL
Plug 'hynek/vim-python-pep8-indent' " Pep-8 style indenting
Plug 'tpope/vim-commentary'         " Block commenting verb
Plug 'AndrewRadev/splitjoin.vim'    " gS 1 line to multi, gJ single

" Syntax and Autocomplete
Plug 'w0rp/ale'                     " Async Linting Engine
Plug 'maralla/completor.vim'        " Code completor (pip install jedi)
call plug#end()

syntax on
filetype plugin indent on
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=
let &runtimepath.=',~/.vim/bundle/ale'
silent! helptags ALL

" Gui Settings 
if has('gui_running')
  set guioptions-=T  " no toolbar
  set guioptions-=e  " no gui tabs
  set guioptions-=m  " no menu
  set mouse=a        " mouse interactive, c for not interactive
  set guifont=Inconsolata\ for\ Powerline\ 14  " my dps is a bit messed up
endif

" Color Scheme
colorscheme jellybeans

" Default Formatting and Indenting
syntax on
set foldmethod=manual     " Don't fold up (see zf)
set clipboard=unnamedplus " System clipboard default
set textwidth=79          " Line width (pep syntax check)
set shiftwidth=4          " operation >> indents 4 columns etc
set tabstop=4             " a hard TAB displays as 4 columns
set expandtab             " insert spaces when hitting TABs
set softtabstop=4         " insert/delete 4 spaces when hitting a TAB/BACKSPACE
set shiftround            " round indent to multiple of 'shiftwidth'
set autoindent            " align the new line indent with the previous line
set smarttab              " tab width determined by shiftwidth
set hidden                " Opening a new buffer hides current, doesnt write
set matchpairs+=<:>       " more pairs we can use, for html etc
set matchtime=2           " 0.2 seconds
set hlsearch              " hilight search results (F8 to un-hilight)
set showmatch             " Hilight matching brackets
set whichwrap+=[]<>hl     " link lines by left/right to prev/next line.
set nowrap                " let lines go off edge of screen
set formatoptions-=t      " dont actually force a newline unless wrapping with gw
set lazyredraw            " don't redraw whilst running macros
set colorcolumn=80        " Show that last column
set scrolloff=30          " 999
set number                " display line numbers
set laststatus=2          " Make sure status line always shows
set shortmess=ITA         " No Intro, Truncate short messages, Abbreviate
set incsearch             " Incremental search
set ssop-=options         " Don't save settings in a session - allows changes to
set ssop-=folds           " this vimrc file to apply to old sessions.
set autochdir             " Make vim automatically change dir to buffer's dir

" Navigate ALE Errors
nmap <silent> <F2> <Plug>(ale_previous)
nmap <silent> <F3> <Plug>(ale_next)

" Completor plugin - hook up tab
" let g:completor_auto_trigger = 0
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>\<cr>" : "\<cr>"

" And close it if you start navigating
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif

" Save when focus lost
set autowrite
au FocusLost * silent! w

" NERDTree file browser
nnoremap <C-f> :NERDTreeFind <CR>
let g:NERDTreeQuitOnOpen = 1
let g:pymode_indent = 0  " Make sure pep8-indent gets to do its thing

" Remove search hilighting
noremap <F8> :nohl<CR> 
inoremap <F8> <C-o>:nohl<CR>

" Insert python debug point after:
map <C-x> oimport IPython; IPython.embed(); import sys; sys.exit()<Esc>^
imap <C-x> import IPython; IPython.embed(); import sys; sys.exit()<CR>

" Disable Q - most of my vim accidents happen when I hit q
map Q <Nop>
map q <Nop>

" Delete without cut to clipboard (handy), Q was now available
noremap q "_d
noremap Q "_D

" Tabline plugin
set showtabline=2  " always show tabline

" use lightline-buffer in lightline
let g:lightline = {
	\ 'tabline': {
		\ 'left': [ [ 'bufferinfo' ], [ 'bufferbefore', 'buffercurrent', 'bufferafter' ], ],
		\ 'right': [ [ 'close' ], ],
		\ },
	\ 'component_expand': {
		\ 'buffercurrent': 'lightline#buffer#buffercurrent2',
		\ },
	\ 'component_type': {
		\ 'buffercurrent': 'tabsel',
		\ },
	\ 'component_function': {
		\ 'bufferbefore': 'lightline#buffer#bufferbefore',
		\ 'bufferafter': 'lightline#buffer#bufferafter',
		\ 'bufferinfo': 'lightline#buffer#bufferinfo',
		\ },
	\ }

" Some shortcuts to delete python comments?
" map q ^f#BE
" nmap <C-#> ^f#BEld$
" nmap <S-#> A  # 

" Lazy whitespace inserting from normal mode
nmap <S-Enter> O<Esc>j
nmap <Enter> o<Esc>k
nnoremap <Space> a<Space><Esc>h
nnoremap <S-Space> i<Space><Esc>l

" Navigate buffers in normal mode with ctrl-tab and ctrl-shift-tab
nnoremap <C-Tab> :bn<CR>
nnoremap <C-S-Tab> :bp<CR>

" Indent and de-indent with Tab and Shift-Tab
nmap <Tab> >>
nmap <S-Tab> <<
vmap <Tab> >gv
vmap <S-Tab> <gv

" Use gs to select the stuff you just pasted/edited...
map gs '[V']

" Weirdest thing in this file - control-space is escape 
inoremap <C-Space> <esc>
vnoremap <C-Space> <esc>
noremap <C-Space> :w<CR>


" Make tmp dirs in standard places
set nobackup
set noswapfile
set undodir=~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.tmp,~/tmp,/var/tmp,/tmp

" Trick for when you forgot to sudo
cmap w!! w !sudo tee >/dev/null %

" " Remove temptation
" nnoremap <Up>    <NOP>
" nnoremap <Down>  <NOP>
" nnoremap <Left>  <NOP>
" nnoremap <Right> <NOP>


