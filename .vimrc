set nocompatible              " be iMproved, required



filetype off                  " required
if has('gui_running')         " GVim only commands

    " auto-install plug if it doesn't exist
    if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall | source $MYVIMRC
    endif

    " set the runtime path to include Vundle and initialize
    " curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    " https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    call plug#begin('~/.vim/plugged')

    Plug 'gmarik/Vundle.vim'      " The plugin manager

    Plug 'Shougo/neocomplete.vim'  " Dan's awesome autocomplete
    " Plug 'Valloric/YouCompleteMe' " Syntax completion for c++
    Plug 'scrooloose/nerdtree'    " Old School File Browser and finder
    Plug 'scrooloose/syntastic'   " Syntax Checker
    Plug 'bling/vim-airline'      " Nicer buffer information display
    " Plug 'fs111/pydoc.vim'        " Python documentation viewer
    Plug 'tpope/vim-commentary'   " Block commenting verb
    Plug 'amix/vim-zenroom'       " Relaxed viewing
    Plug 'justinmk/vim-sneak'     " Sneak
    Plug 'hynek/vim-python-pep8-indent'  " Pep-8 style indenting
    Plug 'kien/ctrlp.vim'  " Buffer navigation/fuzzy search
    " Plug ' davidhalter/jedi-vim'  " vim jedi
    " Nice colour styles
    Plug 'vim-scripts/twilight'
    Plug '29decibel/codeschool-vim-theme'
    Plug 'nanotech/jellybeans.vim'
    Plug 'easymotion/vim-easymotion'  " hilights your motions with \\
    " Plug 'Shougo/unite.vim'  " smart buffer searching
    call plug#end()               " required
    filetype plugin indent on       " required
endif

" Default Formatting and Indenting
syntax on
set textwidth=78  " Line width (pep syntax check seems to need 78?)
set shiftwidth=4  " operation >> indents 4 columns; << unindents 4 columns
set tabstop=4     " a hard TAB displays as 4 columns
set expandtab     " insert spaces when hitting TABs
set softtabstop=4 " insert/delete 4 spaces when hitting a TAB/BACKSPACE
set shiftround    " round indent to multiple of 'shiftwidth'
set autoindent    " align the new line indent with the previous line
set smarttab      " tab width determined by shiftwidth
set hidden        " Opening a new buffer hides current, rather than closing
set matchpairs+=<:> "for html etc
set matchtime=2   "0.2 seconds
set hlsearch      " hilight search results
set wildmenu      " popup window for tab completes in :
set showmatch     " Hilight matching brackets
set whichwrap+=[]<>
set nowrap        " if lines go off edge of screen, just dont show them :)
set formatoptions-=t  " dont actually force a newline unless wrapping with gw

" Visual Appearance
" set cursorline
set lazyredraw    "don't redraw whilst running macros
set ruler
"set relativenumber
set colorcolumn=79
set scrolloff=30  "999
set ttyfast

"set lazyredraw
set number
set t_Co=256        " Approx GUI colour in terminals
set laststatus=2    " Make sure status line always shows
set shortmess=I
set incsearch       " Incremental search
" set wrap

" Session management
set ssop-=options  " Don't save settings in a session - allows changes to
set ssop-=folds    " this vimrc file to apply to old sessions.

" Set up nice fonts etc
if has('gui_running')
  " Get some screen space back:
  set guioptions-=T  " no toolbar
  set guioptions-=m  " no menu
  colorscheme jellybeans
  set mouse=a       " mouse interactive, c for not interactive
  set autochdir     " Make vim automatically change dir to buffer's dir
  set guifont=Inconsolata\ for\ Powerline\ 14  " my dps is a bit messed up
  set foldmethod=indent
  set foldlevel=99
  let g:syntastic_always_populate_loc_list = 1
  " NERDTree file browser
  nnoremap <C-f> :NERDTreeFind <CR>
  let g:NERDTreeQuitOnOpen = 1
endif

"autocmd BufEnter * lcd %:p:h
"autocmd BufEnter * if &modifiable | NERDTreeFind | wincmd p | endif
let g:pymode_indent = 0  " Make sure pep8-indent gets to do its thing
" let g:ycm_key_invoke_completion = ''
" let g:ycm_key_detailed_diagnostics = ''
" let g:ycm_complete_in_strings = 0

" Set up neocomplete.vim
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 2  " for numpy
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'


" Key mappings:
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
"Tab completion:

" Tab should now complete the suggestion!
inoremap <expr><TAB> pumvisible() ? "\<C-y>" : "\<TAB>"
" inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

" <C-h>, <BS>: close popup and delete backword char.
let g:neocomplete#enable_auto_select = 1
inoremap <expr><esc> pumvisible() ? neocomplete#smart_close_popup() : "<esc>"
" inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-g> neocomplete#undo_completion()
inoremap <expr><C-l> neocomplete#complete_common_string()
" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif

" Al's custom maps:
" Gets rid of hilighting after a search
noremap <F8> :nohl<CR> 
inoremap <F8> <C-o>:nohl<CR>
" Auto-fix most python syntax hilighting problems
" DO NOT TRY ON VIMRC!
" noremap <silent> <F9> mz
"             \:silent!%s/\,\(\S\)/\, \1/g<CR>
"             \:silent!%s/  *$//g<CR>
"             \:silent!%s/\(\S\) #/\1  #/g<CR>`z
" Now updated to ignore lines with strings in them!
noremap <silent> <F9> mz
            \:silent!g!/[\"\']/s/\,\(\S\)/\, \1/g<CR>
            \:silent!g!/[\"\']/s/  *$//g<CR>
            \:silent!g!/[\"\']/s/\(\S\) #/\1  #/g<CR>`z
" Insert python debug point:
map <C-x> oimport IPython; IPython.embed(); import sys; sys.exit()<Esc>^
imap <C-x> import IPython; IPython.embed(); import sys; sys.exit()<CR>
" Most of my vim accidents happen when I hit q
" Remap it to something different - delete python comment
map Q <Nop>
map q <Nop>
map q ^f#BE
map Q ^f#BEld$
" Allow inserting whitespace from normal mode
nmap <S-Enter> O<Esc>j
nmap <Enter> o<Esc>k
nnoremap <Space> a<Space><Esc>h
nnoremap <S-Space> i<Space><Esc>l
" Scroll with sensible keys
" imap <C-Up> <Esc>kA
nmap <C-Up> <C-y>
nmap <C-Down> <C-e>
nmap <C-k> <C-y>
nmap <C-j> <C-e>
" Flick through linting errors:
nmap <F3> :lnext<CR>
nmap <F2> :lpre<CR>
"set pastetoggle=<F2> " Get GUI pasting working
" Go forward and backward tabs with ctrl-tab and ctrl-shift-tab
nnoremap <C-Tab> :bn<CR>
nnoremap <C-S-Tab> :bp<CR>
" Indent and de-indent
nmap <Tab> >>
nmap <S-Tab> <<
vmap <Tab> >gv
vmap <S-Tab> <gv
" Allow gs to select the stuff you just pasted/edited...
map gs '[V']
" I actually want ctrl-space for my own purposes - take it back from ycm
inoremap <C-Space> <esc>
vnoremap <C-Space> <esc>
noremap <C-Space> :w<CR>

map x "_d
map X "_D

" Don't make a whole window split to docstring during completion
autocmd FileType python setlocal completeopt-=preview

" Syntax Checking
let g:syntastic_cpp_check_header = 1
" lets use the right python here
let g:syntastic_python_python_exec = '/usr/bin/env python3'
let g:syntastic_python_checkers = ['flake8']
" using flake8-pep257, flake8-pep257, flake8-naming
" use :SyntasticInfo to check availability of flake8
let g:syntastic_python_flake8_args='--ignore=W503,E731,D100,N806'
let g:pydoc_cmd = 'python3 -m pydoc'


" If you prefer the Omni-Completion tip window to close when a selection is
" made, these lines close it on movement
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif

" " YouCompleteMe setting
" let g:ycm_filetype_blacklist = {
"       \ 'tex' : 1,
"       \ 'latex' : 1,
"       \}

" Airline settings
let g:airline_powerline_fonts = 1  " This needs the powerline fonts
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_alt_sep = ' '

" Make tmp dirs in standard places
" set backupdir=~/.tmp, ~/tmp, /var/tmp, /tmp
set nobackup
set noswapfile
set undodir=~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.tmp,~/tmp,/var/tmp,/tmp



" Trick for when you forgot to sudo
cmap w!! w !sudo tee >/dev/null %


" Pydoc readablity
let g:pydoc_window_lines=20

set clipboard=unnamedplus 


