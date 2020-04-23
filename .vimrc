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
    " Plug 'scrooloose/nerdtree'          " Tree based file browser (ctrl-f)
    Plug 'bkad/CamelCaseMotion'           " Break CamelCase into words.
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'               " Advanced file searching
    Plug 'jnurmine/Zenburn'               " Nice dark scheme
    Plug 'tpope/vim-eunuch'               " for :SudoWrite :Rename
    Plug 'itchyny/lightline.vim'          " Status line
    Plug 'taohexxx/lightline-buffer'      " Buffer navigate
    Plug 'moll/vim-bbye'                  " Soft buffer close
    Plug 'easymotion/vim-easymotion'      " hilights your motions with \\
    Plug 'alvan/vim-closetag'             " for html tags
    " Plug 'justinmk/vim-sneak'           " Sneak to character pair with s/z{ab}
    Plug 'tommcdo/vim-lion'               " align characters gl, gL
    Plug 'hynek/vim-python-pep8-indent'   " Pep-8 style indenting
    Plug 'tpope/vim-commentary'           " Block commenting verb
    Plug 'tpope/vim-abolish'              " word manipulation
    Plug 'dense-analysis/ale'               " Async Linting Engine
    Plug 'vim-python/python-syntax'         " Modernise syntax hilighting
    " Plug 'maralla/completor.vim'          " Code completor (pip install jedi)
    " Plug 'LnL7/vim-nix'                   " Syntax & indentation for .nix
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

" I often alias gvim to 'gvim --remote-silent'
" If this starts a new server, wipe the empty document on load
if bufname('%') == ''
  set bufhidden=wipe
endif

" Habit forming
" Normal mode - only up and down and targeted motions
nnoremap <Up>  <NOP>
nnoremap <Down> <NOP>
nnoremap <Left>  <NOP>
nnoremap <Right> <NOP>


" Attempt to make esk/jk more responsive
" :set esckeys
set ttimeoutlen=0
set timeoutlen=1000
" set timeout                 " Key mappings go away after a little while
" set tw=100                  " Wait 0.1 seconds for key combo (default is 1!)

" Color Scheme: Zenburn, seoul256, seoul256-light, jellybeans
colorscheme zenburn

" Improved python hilighting
let g:python_highlight_all = 1
" Linting setup:
" let &runtimepath.=',~/.vim/bundle/ale'
let g:ale_lint_on_text_changed='normal'
let g:ale_lint_on_insert_leave=1
let g:ale_echo_msg_format='[%linter%] %code:%%s'  
" speed up suggested on site
let g:pymode_rope = 0
nnoremap <silent> <Up>  :ALEPreviousWrap<cr>
nnoremap <silent> <Down> :ALENextWrap<cr>
nnoremap <Left>  [s
nnoremap <Right> ]s

:noremap <leader>e :s/\.\ /.\r# /g<CR>

" au FocusLost * :echo "Focus lost: saving all buffers" | :silent wall

" Default Formatting and Indenting
syntax on
filetype plugin indent on
set ttyfast
set noro                    " Don't disable buffer editing on read only files...(just saving)
set showtabline=2           " 0 = no tabline, 2 = always
set foldmethod=manual       " Don't fold up (see zf)
set bri                     " indent if wrapping
set spelllang=en_au         " Australian english if spelling
set clipboard=unnamedplus   " System clipboard default
" let colorcolumn handle it
" set textwidth=79            " Line width (pep syntax check)
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
set hlsearch                " hilight search results (F8 to un-hilight)
set whichwrap+=[]<>hl       " link lines by left/right to prev/next line.
set nowrap                  " let lines go off edge of screen
set linebreak               " don't wrap half way through a word
set nolist                  " list disables linebreak apparently
set formatoptions=
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
let mapleader =             " "       " Default leader is too far
let g:fzf_command_prefix = 'Fzf'
let g:pymode_indent = 0     " Make sure pep8-indent gets to do its thing
let g:tex_flavor='latex'    " Formatting style.
set completeopt=menuone,noselect
" let g:completor_complete_options='menuone,noselect'

let g:deoplete#enable_at_startup = 1

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
"     au FileType tex setlocal spell 
"     au FileType tex setlocal iskeyword+=: 
" augroup END

inoremap jk <Esc><Esc>
" inoremap <expr> jk pumvisible() ? "<Esc><Esc>" : "<Esc>"

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

" If vim crashes, use recovery mode: vim -r filename
set dir=~/.vim/swap/
set nobackup
set noundofile
set swapfile

" Custom fzf stuff:
let g:fzf_layout = { 'down': '~40%' }
nnoremap <silent> <leader>b :FzfBuffers<CR>
command! -bang -nargs=* FzfAu call fzf#vim#grep('rg --type py --no-heading --line-number .$ ~/code/', 0)
command! -bang -nargs=* FzfProj call fzf#run({'source': 'lsproject', 'left': '30%', 'sink': 'e'})
nnoremap <silent> <leader>n :lcd %:p:h<CR>:FzfProj<CR>
nnoremap <silent> <leader>a :FzfAu<CR>

""" Quicker assisted find (usually leader-leader):
map <leader>f <Plug>(easymotion-f)
map <leader>F <Plug>(easymotion-F)

" nnoremap <silent> <leader>l :FzfLines<CR>
" nnoremap <silent> <C-f> :NERDTree <CR>
nnoremap <silent> <C-f> <Nop>

" For navigating fzf menus 
nnoremap <C-k> a<C-x>s<C-p>
nnoremap <C-j> a<C-x>s<C-p>

" completor using ctrl-j and ctrl-k with auto-close. <C-n>=Down, <C-p>
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : ""
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : ""
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <CR> pumvisible() ? "\<C-y><Esc>" : "\<CR>"
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
" and vim spelling
nnoremap <leader>s ea<C-X><C-S>

nnoremap <C-x> oimport smart_embed<CR>smart_embed.embed(locals(), globals())<CR><ESC>
inoremap <C-x> import smart_embed<CR>smart_embed.embed(locals(), globals())<CR>
" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html setlocal omnifunc=htmlcomplete#CompleteTags


" Turn off q
nnoremap q :nohl<CR>
nnoremap Q lD

" Avoid accidental macros
vnoremap q <Nop>
vnoremap Q <Nop>

" Insert whitespace without entering insert mode
nnoremap <S-Enter> O<Esc><Down>
nnoremap <Enter> o<Esc><Up>
nnoremap <C-Enter> d$O<Esc>p
nnoremap L :bn<CR>
nnoremap H :bp<CR>
nmap <Tab> >>
nmap <S-Tab> <<
vmap <Tab> >gv
vmap <s-tab> <gv
" map gs '[V']
" or :SudoWrite<CR>
nnoremap K :w<CR>
vnoremap K V:w<CR>
" disable two sequence window navigation
inoremap <C-w> <NOP>
nmap <silent> <C-w> :Bdelete<CR>
nmap <silent> <C-z> :wincmd q<CR>
nmap <silent> <C-s> :vsplit<CR>
nmap <silent> <C-h> :wincmd h<CR>
nmap <silent> <C-l> :wincmd l<CR>
nmap X 0D
imap X- X_
imap <f2> <esc>b~ea



" A plugin is unsetting this:
iabbrev +- ±
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

" Allow wrapping
function ToggleWrap()
  if &wrap
    echo "Wrap OFF"
    setlocal nowrap
    set virtualedit=all
    silent! nunmap <buffer> <Up>
    silent! nunmap <buffer> <Down>
    silent! nunmap <buffer> <Home>
    silent! nunmap <buffer> <End>
    silent! iunmap <buffer> <Up>
    silent! iunmap <buffer> <Down>
    silent! iunmap <buffer> <Home>
    silent! iunmap <buffer> <End>
    silent! nunmap <buffer> j
    silent! nunmap <buffer> k
  else
    echo "Wrap ON"
    setlocal wrap nolist
    set virtualedit=
    setlocal display+=lastline
    noremap  <buffer> <silent> <Up>   gk
    noremap  <buffer> <silent> <Down> gj
    noremap  <buffer> <silent> <Home> g<Home>
    noremap  <buffer> <silent> <End>  g<End>
    inoremap <buffer> <silent> <Up>   <C-o>gk
    inoremap <buffer> <silent> <Down> <C-o>gj
    inoremap <buffer> <silent> <Home> <C-o>g<Home>
    inoremap <buffer> <silent> <End>  <C-o>g<End>
    noremap <buffer> <silent> j gj
    noremap <buffer> <silent> k gk
  endif
endfunction
noremap <silent> <Leader>w :call ToggleWrap()<CR>

" let g:completor_blacklist=['text', 'markdown']
" autocmd FileType tex,text setlocal complete=""
" autocmd FileType tex setlocal noai nocin nosi inde=
" autocmd FileType tex setlocal linebreak wrap columns=86
" autocmd FileType text nmap <F2> [s
" autocmd FileType text nmap <F3> ]s
autocmd FileType text,markdown,tex call ToggleWrap()
autocmd FileType text,markdown,tex,html setlocal shiftwidth=2|setlocal spell|syntax spell toplevel
let g:tex_coment_nospell=1
"     au FileType tex setlocal tabstop=2 
"
"
" Handy tip: control-v captures the keystroke

" Laptop has horribly placed pg keys
inoremap <PageUp> <Nop>
inoremap <PageDown> <Nop>
noremap <PageUp> <Nop>
noremap <PageDown> <Nop>

" HTML tag plugin
let g:closetag_filenames = '*.html,*.xhtml,*.phtml'
let g:closetag_filetypes = 'html,xhtml,phtml'
let g:closetag_emptyTags_caseSensitive = 1

let g:closetag_shortcut = '>'
let g:closetag_close_shortcut = '<C>>'

" Some plugin is unsetting this...
set textwidth=0            " was 79, dont auto Line width (pep syntax check)
set wrapmargin=0
