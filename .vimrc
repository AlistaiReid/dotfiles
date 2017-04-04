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
Plug 'bling/vim-airline'            " Buffer information display (ctrl-tab)
Plug 'nanotech/jellybeans.vim'      " Dark colourscheme
Plug 'tpope/vim-eunuch'             " for :SudoWrite :Rename

" Navigation
Plug 'easymotion/vim-easymotion'    " hilights your motions with \\
Plug 'justinmk/vim-sneak'           " Sneak to character pair with s/z{ab}

" Code Operations
Plug 'b4winckler/vim-angry'        " Navigate comma separated arguments
Plug 'tommcdo/vim-lion'             " align characters (glip=, 3gLi)
Plug 'hynek/vim-python-pep8-indent' " Pep-8 style indenting
Plug 'tpope/vim-commentary'         " Block commenting verb
Plug 'AndrewRadev/splitjoin.vim'    " gS 1 line to multi, gJ single

" Syntax and Autocomplete
Plug 'w0rp/ale'               " Async Linting Engine
Plug 'maralla/completor.vim'  " Code completor (pacin python3-jedi)
call plug#end()

syntax on
filetype plugin indent on

" Misc Housekeeping
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=
let &runtimepath.=',~/.vim/bundle/ale'
silent! helptags ALL

" Gui Settings 
if has('gui_running')
  set guioptions-=T  " no toolbar
  set guioptions-=m  " no menu
  set mouse=a        " mouse interactive, c for not interactive
  set guifont=Inconsolata\ for\ Powerline\ 14  " my dps is a bit messed up
  set foldmethod=indent
  set foldlevel=99
endif


" Default Formatting and Indenting
syntax on
set clipboard=unnamedplus " System clipboard default
set textwidth=78          " Line width (pep syntax check seems to prefer 78?)
set shiftwidth=4          " operation >> indents 4 columns; << unindents 4 columns
set tabstop=4             " a hard TAB displays as 4 columns
set expandtab             " insert spaces when hitting TABs
set softtabstop=4         " insert/delete 4 spaces when hitting a TAB/BACKSPACE
set shiftround            " round indent to multiple of 'shiftwidth'
set autoindent            " align the new line indent with the previous line
set smarttab              " tab width determined by shiftwidth
set hidden                " Opening a new buffer hides current, rather than closing
set matchpairs+=<:>       "for html etc
set matchtime=2           "0.2 seconds
set hlsearch              " hilight search results
set showmatch             " Hilight matching brackets
set whichwrap+=[]<>
set nowrap                " if lines go off edge of screen, just dont show them :)
set formatoptions-=t      " dont actually force a newline unless wrapping with gw
set lazyredraw            " don't redraw whilst running macros
set ruler
set colorcolumn=80
set scrolloff=30          "999
set ttyfast
set number
set laststatus=2          " Make sure status line always shows
set shortmess=I
set incsearch             " Incremental search
set ssop-=options         " Don't save settings in a session - allows changes to
set ssop-=folds           " this vimrc file to apply to old sessions.


" ALE Navigate Errors
nmap <silent> <F2> <Plug>(ale_previous_wrap)
nmap <silent> <F3> <Plug>(ale_next_wrap)

" Completor plugin - hook up tab
" let g:completor_auto_trigger = 0
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>\<cr>" : "\<cr>"
" inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<C-x>\<C-u>\<C-p>"

" NERDTree file browser
set autochdir     " Make vim automatically change dir to buffer's dir
nnoremap <C-f> :NERDTreeFind <CR>
let g:NERDTreeQuitOnOpen = 1
colorscheme jellybeans
let g:pymode_indent = 0  " Make sure pep8-indent gets to do its thing

" Al's custom maps:

" Remove search hilighting
noremap <F8> :nohl<CR> 
inoremap <F8> <C-o>:nohl<CR>

" Insert python debug point:
map <C-x> oimport IPython; IPython.embed(); import sys; sys.exit()<Esc>^
imap <C-x> import IPython; IPython.embed(); import sys; sys.exit()<CR>

" Disable Q - most of my vim accidents happen when I hit q
map Q <Nop>
map q <Nop>
" map q ^f#BE
" map Q ^f#BEld$

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

" Delete without cut to clipboard (handy)
map x "_d
map X "_D

" Airline settings
let g:airline_powerline_fonts = 1  " This needs the powerline fonts
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_alt_sep = ' '

" Make tmp dirs in standard places
set nobackup
set noswapfile
set undodir=~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.tmp,~/tmp,/var/tmp,/tmp

" Trick for when you forgot to sudo
cmap w!! w !sudo tee >/dev/null %



