" Require GVIM 8.0+ 
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
    Plug 'takac/vim-hardtime'             " force learning by blocking repeats
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
  set guifont=Inconsolata\ Regular\ 14
endif

" Color Scheme: Zenburn, seoul256, seoul256-light, jellybeans
colorscheme zenburn

" Linting setup:
let &runtimepath.=',~/.vim/bundle/ale'

" Default Formatting and Indenting
syntax on
filetype plugin indent on
set foldmethod=manual     " Don't fold up (see zf)
set clipboard=unnamedplus " System clipboard default
set textwidth=79          " Line width (pep syntax check)
set shiftwidth=4          " operation >> indents 4 columns etc
set tabstop=4             " a hard TAB displays as 4 columns
set expandtab             " insert spaces when hitting TABs
set softtabstop=4         " insert/delete 4 spaces when hitting a TAB/BACKSPACE
set noshiftround          " don't round indent to multiple of 'shiftwidth'
set autoindent            " align the new line indent with the previous line
set smarttab              " tab width determined by shiftwidth
set hidden                " You can switch buffers without saving
set matchpairs+=<:>       " more pairs we can use, for html etc
set matchtime=2           " 0.2 seconds
set hlsearch              " hilight search results (F8 to un-hilight)
set whichwrap+=[]<>hl     " link lines by left/right to prev/next line.
set nowrap                " let lines go off edge of screen
set formatoptions-=t      " dont actually force a newline unless wrapping with gw
set formatoptions-=cro    " dont comment on next line
set lazyredraw            " don't redraw whilst running macros
set colorcolumn=80        " Show that last column
set scrolloff=10          " How close can you get to the edge without scrolling
set number                " display line numbers
set laststatus=2          " Make sure status line always shows
set shortmess=ITA         " No Intro, Truncate short messages, Abbreviate
set incsearch             " Incremental search
set ssop-=options         " Don't save settings in a session - allows changes to
set ssop-=folds           " this vimrc file to apply to old sessions.
set equalalways           " Keep splits the same size
set autochdir             " Make vim automatically change dir to buffer's dir
set showtabline=2         " always show tabline
set tw=100                " Wait 0.1 seconds for key combo (default is 1!)
let mapleader = ";"       " Default leader is too far
let g:fzf_command_prefix = 'Fzf'
let g:pymode_indent = 0   " Make sure pep8-indent gets to do its thing
let g:tex_flavor='latex'  " Formatting style.

" Vim-hardtime
let g:hardtime_default_on = 1  " Hard time on every buffer
let g:list_of_normal_keys = ["h", "j", "k", "l"]
let g:list_of_visual_keys = ["h", "j", "k", "l"]
let g:list_of_insert_keys = ["<UP>", "<DOWN>", "<LEFT>", "<RIGHT>"]
let g:hardtime_maxcount = 2   " allow two presses (default is 1)
let g:hardtime_timeout = 1000  " punishment time (ms)
let g:list_of_disabled_keys = []

" " Tex-specific configuration
" augroup ft_tex
"     au!
"     au FileType tex setlocal formatoptions="" 
"     au FileType tex setlocal textwidth=0
"     au FileType tex setlocal wrapmargin=0
"     au FileType tex setlocal wrap
"     au FileType tex setlocal breakindent
"     au FileType tex setlocal shiftwidth=2 
"     au FileType tex setlocal tabstop=2 
"     au FileType tex setlocal spelllang=en_gb 
"     au FileType tex setlocal linebreak 
"     au FileType tex setlocal spell 
"     au FileType tex setlocal iskeyword+=: 
" augroup END

" Completor plugin - hook up tab
inoremap <expr> <j> pumvisible() ? "\<C-y>\<cr>" : "\j"
inoremap <expr> <Tab> pumvisible() ? "\<C-y>\<cr>" : "\<Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>\<cr>" : "\<cr>"
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

" Make tmp dirs in standard places
set nobackup
set noswapfile
set undodir=~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.tmp,~/tmp,/var/tmp,/tmp

" Custom Ag
command! -bang -nargs=* FzfAu call fzf#vim#grep('ag --nogroup --color -G ".*py$" ".$" ~/code/glabrezu/glabrezu ~/code/dretch/dretch ~/code/modron/modron', 0)

""" Custom key-maps:
map f <Plug>(easymotion-f)
map F <Plug>(easymotion-F)
nnoremap <silent> <leader>n :FzfFiles<CR>
nnoremap <silent> <leader>b :FzfBuffers<CR>
nnoremap <silent> <leader>l :FzfLines<CR>
nnoremap <silent> <leader>a :FzfAu<CR>
nnoremap <silent> <F2> <Plug>(ale_previous)
nnoremap <silent> <F3> <Plug>(ale_next)
nnoremap <silent> <C-f> :NERDTree <CR>
map <C-x> oimport debug<CR>debug.embed(locals(), globals(), False)<CR><ESC>
imap <C-x> import debug<CR>debug.embed(locals(), globals(), False)<CR>
imap <Esc> <Nop>
nmap q :nohl<CR>
vmap x "_d
nnoremap <S-Enter> O<Esc><Down>
nnoremap <Enter> o<Esc><Up>
nnoremap <Space> f<Space>
nnoremap <S-Space> F<Space>
" nnoremap <Space> a<Space><esc><Left>
" nnoremap <S-Space> i<Space><esc><Right>
nnoremap L :bn<CR>
nnoremap H :bp<CR>
nmap <Tab> >>
nmap <S-Tab> <<
vmap <Tab> >gv
vmap <s-tab> <gv
map gs '[V']
inoremap jk <esc>
nnoremap K :SudoWrite<CR>
nmap <silent> <A-w> :Bdelete<CR>
nmap <silent> <A-c> :wincmd c<CR>
nmap <silent> <A-s> :vsplit<CR>
nmap <silent> <A-=> :wincmd =<CR>
nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>
nnoremap <Up>  <NOP>
nnoremap <Down> <NOP>
nnoremap <Left>  <NOP>
nnoremap <Right> <NOP>
nnoremap gh ^
nmap X 0D

" {experimental} open, push and close...
python import vim
nmap <F4> :python py_link = open('/home/areid/.py_link', 'w')<CR>
nmap <F5> :python py_link.write(vim.current.line + "\n"); py_link.flush()<CR>
vmap <F5> y:python py_link.write("%paste\nglobals().update(locals())\n"); py_link.flush()<CR>
nmap <F6> :python py_link.close()<CR>

" A plugin is unsetting this:
set textwidth=79          " Line width (pep syntax check)
imap +- ±
let g:EasyMotion_keys='abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890'
