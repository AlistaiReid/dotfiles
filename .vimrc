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
    Plug 'bkad/CamelCaseMotion'           " Break CamelCase into words.
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'               " Advanced file searching
    Plug 'jnurmine/Zenburn'               " Nice dark one
    Plug 'tpope/vim-eunuch'               " for :SudoWrite :Rename
    Plug 'itchyny/lightline.vim'          " Status line
    Plug 'taohex/lightline-buffer'        " Buffer navigate
    " Plug 'junegunn/limelight.vim'         " Hilight current paragraph
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

set noshowmode  " its already shown by lightline

" Gui Settings 
if has('gui_running')
  set guioptions-=T  " no toolbar
  set guioptions-=e  " no gui tabs
  set guioptions-=m  " no menu
  set mouse=a        " mouse interactive, c for not interactive
  set guifont=Inconsolata\ Regular\ 14
endif

" Attempt to make esk/jk more responsive
:set esckeys
set ttimeoutlen=0
set timeoutlen=1000
" set timeout                 " Key mappings go away after a little while
" set tw=100                  " Wait 0.1 seconds for key combo (default is 1!)

" Color Scheme: Zenburn, seoul256, seoul256-light, jellybeans
colorscheme zenburn

" Linting setup:
let &runtimepath.=',~/.vim/bundle/ale'
let g:ale_lint_on_text_changed='normal'
let g:ale_lint_on_insert_leave=1

" Default Formatting and Indenting
syntax on
filetype plugin indent on
set foldmethod=manual       " Don't fold up (see zf)
set clipboard=unnamedplus   " System clipboard default
set textwidth=79            " Line width (pep syntax check)
set shiftwidth=4            " operation >> indents 4 columns etc
set tabstop=4               " a hard TAB displays as 4 columns
set expandtab               " insert spaces when hitting TABs
set softtabstop=4           " insert/delete 4 spaces when hitting a TAB/BACKSPACE
set shiftround              " don't round indent to multiple of 'shiftwidth'
set autoindent              " align the new line indent with the previous line
set smarttab                " tab width determined by shiftwidth
set hidden                  " You can switch buffers without saving
set matchpairs+=<:>         " more pairs we can use, for html etc
set noshowmatch             " don't freeze up trying to find a match.
" set matchtime=2             " 0.2 seconds
set hlsearch                " hilight search results (F8 to un-hilight)
set whichwrap+=[]<>hl       " link lines by left/right to prev/next line.
set nowrap                  " let lines go off edge of screen
set formatoptions-=t        " dont actually force a newline unless wrapping with gw
set formatoptions=
" set formatoptions-=cro      " dont comment on next line
set lazyredraw              " don't redraw whilst running macros
set colorcolumn=80          " Show that last column
set scrolloff=80            " How close can you get to the edge without scrolling
set number                  " display line numbers
set laststatus=2            " Make sure status line always shows
set shortmess=ITA           " No Intro, Truncate short messages, Abbreviate
set incsearch               " Incremental search
set ssop-=options           " Don't save settings in a session - allows changes to
set ssop-=folds             " this vimrc file to apply to old sessions.
set equalalways             " Keep splits the same size
set autochdir               " Make vim automatically change dir to buffer's dir
set showtabline=2           " always show tabline
let mapleader =             " "       " Default leader is too far
let g:fzf_command_prefix = 'Fzf'
let g:pymode_indent = 0     " Make sure pep8-indent gets to do its thing
let g:tex_flavor='latex'    " Formatting style.
set completeopt=menuone  " ,noselect,noinsert

" " Vim-hardtime
" let g:hardtime_maxcount=1   " allow two presses (default is 1)
" let g:hardtime_timeout=100  " punishment time (ms)
" let g:hardtime_allow_different_key=1
" let g:hardtime_default_on = 1  " Hard time on every buffer
" let g:list_of_normal_keys = ["h", "l"]
" let g:list_of_visual_keys = ["h", "l"]
" let g:list_of_insert_keys = ["<UP>", "<DOWN>"]
" let g:list_of_disabled_keys = []

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


inoremap jk <Esc><Esc>:SudoWrite<CR>
inoremap kj <Esc><Esc>:SudoWrite<CR>
inoremap jK <Esc><Esc>:SudoWrite<CR>
inoremap JK <Esc><Esc>:SudoWrite<CR>
inoremap Jk <Esc><Esc>:SudoWrite<CR>
"
" inoremap jk <Esc><Esc>  " Doesnt like popups
" inoremap <expr> jk pumvisible() ? "<Esc><Esc>" : "<Esc>"
" NERDTree file browser
let g:NERDTreeQuitOnOpen = 1

" use lightline-buffer in lightline
let g:lightline = {
	\ 'colorscheme': 'wombat',
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
" command! -bang -nargs=* FzfAu call fzf#vim#grep('ag --nogroup --color -G ".*py$" ".$" ~/code/glabrezu/glabrezu ~/code/dretch/dretch ~/code/modron/modron', 0)
" ripgrep is beast!
" command! -bang -nargs=* FzfAu call fzf#vim#grep('rg --type py --no-heading --line-number . ../ ~/code/glabrezu/glabrezu ~/code/dretch/dretch ~/code/modron/modron', 0)
command! -bang -nargs=* FzfAu call fzf#vim#grep('rg --type py --no-heading --line-number .$ ~/code/', 0)

""" Quicker assisted find (usually leader-leader):
map <leader>f <Plug>(easymotion-f)
map <leader>F <Plug>(easymotion-F)

" {n}ame, {b}uffers, {l}ines, {a}g
nnoremap <silent> <leader>n :FzfFiles<CR>
nnoremap <silent> <leader>b :FzfBuffers<CR>
nnoremap <silent> <leader>l :FzfLines<CR>
nnoremap <silent> <leader>a :FzfAu<CR>
nnoremap <silent> <C-f> :NERDTree <CR>


" completor using ctrl-j and ctrl-k with auto-close. <C-n>=Down, <C-p>
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : ""
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : ""
inoremap <C-Space> <Enter><Esc>
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
nnoremap <C-k> a<C-x>s

nnoremap <C-x> oimport debug<CR>debug.embed(locals(), globals())<CR><ESC>
inoremap <C-x> import debug<CR>debug.embed(locals(), globals())<CR>

imap <Esc> <Nop>
nnoremap q :nohl<CR>
nnoremap Q lD
" vmap x "_d
" nnoremap <Space> f<Space>
" nnoremap <S-Space> F<Space>
nnoremap <S-Enter> O<Esc><Down>
nnoremap <Enter> o<Esc><Up>
" nnoremap <C-h> a<Space><esc><Left>
" nnoremap <C-l> i<Space><esc><Right>
" nnoremap <C-j> O<Esc><Down>
" nnoremap <C-k> o<Esc><Up>

nnoremap L :bn<CR>
nnoremap H :bp<CR>
nmap <Tab> >>
nmap <S-Tab> <<
vmap <Tab> >gv
vmap <s-tab> <gv
map gs '[V']
nnoremap K :SudoWrite<CR>
inoremap <C-w> <NOP>
nmap <silent> <C-c> :Bdelete<CR>
nmap <silent> <C-w> :wincmd c<CR>
nmap <silent> <A-s> :vsplit<CR>
nmap <silent> <A-=> :wincmd =<CR>
nmap <silent> <A-k> :wincmd k<CR>
nmap <silent> <A-j> :wincmd j<CR>
nmap <silent> <A-h> :wincmd h<CR>
nmap <silent> <A-l> :wincmd l<CR>
nmap X 0D

" Normal mode - only up and down and targeted motions
" nnoremap h <NOP>
" nnoremap l <NOP>
nnoremap <Up>  <NOP>
nnoremap <Down> <NOP>
nnoremap <Left>  <NOP>
nnoremap <Right> <NOP>

" Insert mode - only left, right for spelling correction
" inoremap <Up> <NOP>
" inoremap <Down> <NOP>

" {experimental} open, push and close...
nmap <F8> :source ~/.vimrc<CR>
" python import vim
" nmap <F4> :python py_link = open('/home/areid/.py_link', 'w')<CR>
" nmap <F5> :python py_link.write(vim.current.line + "\n"); py_link.flush()<CR>
" vmap <F5> y:python py_link.write("%paste\nglobals().update(locals())\n"); py_link.flush()<CR>
" nmap <F6> :python py_link.close()<CR>

" A plugin is unsetting this:
imap +- ±
let g:EasyMotion_keys='abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890'

" Fancy movement
" nmap ( <Plug>(IndentWisePreviousLesserIndent)
" nmap ) <Plug>(IndentWiseNextGreaterIndent)
" map <C-[> <Plug>(IndentWisePreviousEqualIndent)
" map <C-]> <Plug>(IndentWiseNextEqualIndent)

" Navigate errors
nnoremap <silent> <F2> :lprev<CR>
nnoremap <silent> <F3> :lnext<CR>
" nnoremap <silent> <S-Enter> :lopen<CR>

" CamelCase Motion
map <silent> w <Plug>CamelCaseMotion_w
map <silent> b <Plug>CamelCaseMotion_b
map <silent> e <Plug>CamelCaseMotion_e
map <silent> ge <Plug>CamelCaseMotion_ge
sunmap w
sunmap b
sunmap e
sunmap ge

" Some plugin is unsetting this...
set textwidth=79            " Line width (pep syntax check)

" Don't code-complete english:
let g:completor_blacklist=['text', 'markdown']
autocmd FileType text setlocal spell spelllang=en_au
autocmd FileType text setlocal complete=""

