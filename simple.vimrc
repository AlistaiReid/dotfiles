" Beginner config for VIM 8 as a Python IDE
" Require GVIM 8.0+ 
" Run :PlugUpdate on first load.
set nocompatible
filetype off

" Auto-install plugin manager if it doesnt exist (and PlugInstall)
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

" List of active plugins
call plug#begin('~/.vim/plugged')
    Plug 'scrooloose/nerdtree'            " Tree based file browser (ctrl-f)
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'               " Advanced file searching
    Plug 'rafi/awesome-vim-colorschemes'  " Many colourschemes
    Plug 'jnurmine/Zenburn'               " Nice dark one
    Plug 'tpope/vim-eunuch'               " for :SudoWrite :Rename
    Plug 'itchyny/lightline.vim'          " Status line
    Plug 'taohex/lightline-buffer'        " Buffer navigate
    Plug 'junegunn/limelight.vim'         " Hilight current paragraph
    Plug 'moll/vim-bbye'                  " Soft buffer close
    Plug 'easymotion/vim-easymotion'      " hilights your motions with \\
    Plug 'justinmk/vim-sneak'             " Sneak to character pair with s/z{ab}
    Plug 'tommcdo/vim-lion'               " align characters gl, gL
    Plug 'hynek/vim-python-pep8-indent'   " Pep-8 style indenting
    Plug 'tpope/vim-commentary'           " Block commenting verb
    Plug 'w0rp/ale'                       " Async Linting Engine
    Plug 'maralla/completor.vim'          " Code completor (pip install jedi)
call plug#end()

" No bells
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=
silent! helptags ALL

" Gui Settings 
if has('gui_running')
  set guioptions-=T  " no toolbar
  set guioptions-=e  " no gui tabs
  set guioptions-=m  " no menu
  set mouse=a        " mouse interactive, c for not interactive
  set guifont=Inconsolata\ Regular\ 13
endif

" Color Schemes: try Zenburn, seoul256, seoul256-light, jellybeans
colorscheme zenburn

" Linting setup:
let &runtimepath.=',~/.vim/bundle/ale'

" Default Formatting and Indenting
syntax on
filetype plugin indent on
set foldmethod=manual     " turn folding off for now (see zf)
set clipboard=unnamedplus " System clipboard default
set textwidth=79          " Line width (pep syntax check)
set shiftwidth=4          " operation >> indents 4 columns etc
set tabstop=4             " a hard TAB displays as 4 columns
set expandtab             " insert spaces when hitting TABs
set softtabstop=4         " insert/delete 4 spaces when hitting a TAB/BACKSPACE
set shiftround            " don't round indent to multiple of 'shiftwidth'
set autoindent            " align the new line indent with the previous line
set smarttab              " tab width determined by shiftwidth
set hidden                " You can switch buffers without saving
set matchpairs+=<:>       " more pairs we can use, for html etc
set matchtime=2           " 0.2 seconds max search time
set hlsearch              " hilight search results (F8 to un-hilight)
set whichwrap+=[]<>hl     " link lines by left/right to prev/next line.
set nowrap                " let lines go off edge of screen
set formatoptions=
set lazyredraw            " don't redraw whilst running macros
set colorcolumn=80        " Show that last column
set scrolloff=80          " How close can you get to the edge without scrolling
set number                " display line numbers
set laststatus=2          " Make sure status line always shows
set shortmess=ITA         " No Intro, Truncate short messages, Abbreviate
set incsearch             " Incremental search
set ssop-=options         " Don't save settings in a session - allows changes to
set ssop-=folds           " this vimrc file to apply to old sessions.
set equalalways           " Keep splits the same size where possible
set autochdir             " Make vim automatically change dir to buffer's dir
set showtabline=2         " always show tabline
" let mapleader = " "       " Default leader is too costly
let g:fzf_command_prefix = 'Fzf'
let g:pymode_indent = 0   " Make sure pep8-indent gets to do its thing
let g:tex_flavor='latex'  " Formatting style.
set timeout               " Key mappings go away after a little while
set tw=200                " Wait 0.1 seconds for key combo (default is 1!)
set completeopt=menuone,noselect,noinsert

" Completion prompts use ctrl-j and ctrl-k with auto-close.
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<S-Tab>"
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif

" NERDTree file browser
let g:NERDTreeQuitOnOpen = 1

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

set nobackup
set noundofile
" If vim crashes, use recovery mode: vim -r filename
set dir=~/.vim/swap/
set swapfile

" Custom fzf#Ag
command! -bang -nargs=* FzfAu call fzf#vim#grep('rg --type py --no-heading --line-number . ~/code/', 0)

""" Custom key-maps:
map <leader>f <Plug>(easymotion-f)
map <leader>F <Plug>(easymotion-F)
" {n}ame, {b}uffers, {l}ines, {a}g
nnoremap <silent> <leader>n :FzfFiles<CR>
nnoremap <silent> <leader>b :FzfBuffers<CR>
nnoremap <silent> <leader>l :FzfLines<CR>
nnoremap <silent> <leader>a :FzfAu<CR>
nnoremap <silent> <C-f> :NERDTree <CR>
map <C-x> oimport ipython<CR>ipython.embed()<CR><ESC>
imap <C-x> import ipython<CR>ipython.embed()<CR>
nmap q :nohl<CR>
nnoremap L :bn<CR>
nnoremap H :bp<CR>
nmap <Tab> >>
nmap <S-Tab> <<
vmap <Tab> >gv
vmap <s-tab> <gv
map gs '[V']
inoremap jk <esc>
nnoremap K :SudoWrite<CR>
inoremap <C-w> <NOP>
nmap <silent> <C-c> :Bdelete<CR>
nmap <silent> <C-w> :wincmd c<CR>
imap +- ±

" Navigate errors
nnoremap <silent> <F2> <Plug>(ale_previous_wrap)
nnoremap <silent> <F3> <Plug>(ale_next_wrap)
