" Require GVIM 8.0+ 
set nocompatible
filetype off

" Auto-install plugin manager if it doesnt exist (and PlugInstall)
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

" Stop the annoying message on load
" set cmdheight=1  " 2 means fewer messages where you need to press enter

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
    Plug 'dense-analysis/ale'               " Async Linting Engine (not required)
    Plug 'vim-python/python-syntax'         " Modernise syntax hilighting
    " Plug 'neoclide/coc.nvim', {'branch': 'release'}  " Good completor
    " NOTE, for language integrations, type these 
    " :CocConfig for config file
    " - python, :CocInstall coc-python
    " - latex, :CocInstall coc-vimtex
    " - texlab, :CocInstall coc-texlab  (requires pacin texlab)
    " - html, :CocInstall coc-html
    " - css, :CocInstall coc-css
    " - json, :CocInstall coc-json
    " - colors, :CocInstall coc-highlight  previews colors
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
" let g:ale_lint_on_text_changed='normal'
" let g:ale_lint_on_insert_leave=1
" let g:ale_echo_msg_format='[%linter%] %code:%%s'  
" speed up suggested on site
" let g:pymode_rope = 0
" nnoremap <silent> <Up>  :ALEPreviousWrap<cr>
" nnoremap <silent> <Down> :ALENextWrap<cr>
" nnoremap <Left>  [s
" nnoremap <Right> ]s

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
set shortmess=a             " No Intro, Truncate short messages, Abbreviate
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
" let g:deoplete#enable_at_startup = 1
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

" Recommendations for coc.vim ========================================
set cmdheight=1  " they recommend 2
set updatetime=250  " its usually 4 seconds (4000)
set shortmess+=c  " dont pass messages to completion menu
set signcolumn=yes  " always show otherwise diagnostics

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? "\<C-n>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
" function! s:check_back_space() abort
"   let col = col('.') - 1
"   return !col || getline('.')[col - 1]  =~# '\s'
" endfunction

" Use <c-space> to trigger completion. [important]
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics (or F2/F3)
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <silent> <F2> <Plug>(coc-diagnostic-prev)
nmap <silent> <F3> <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
" So much better than a split window
nnoremap <silent> <leader>d :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
" I don't like this
" autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming - really cool
nmap <leader>r <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>g  <Plug>(coc-format-selected)
nmap <leader>g  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" " Example: `<leader>aap` for current paragraph
" xmap <leader>a  <Plug>(coc-codeaction-selected)
" nmap <leader>a  <Plug>(coc-codeaction-selected)

" " Remap keys for applying codeAction to the current line.
" nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
" must be quick fix - doesn't work too well
" nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
" in function, in class
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" " Use CTRL-S for selections ranges.
" " Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
" nmap <silent> <C-s> <Plug>(coc-range-select)
" xmap <silent> <C-s> <Plug>(coc-range-select)

" " Add `:Format` command to format current buffer with autopep8
" command! -nargs=0 Format :call CocAction('format')

" " Add `:Fold` command to fold current buffer.
" command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
" requires isort
" command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
" conflict with lightline etc?
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings using CoCList:
" Show all diagnostics.
" nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
" nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
" nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
" nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
" nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
" nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" " Do default action for previous item.
" nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
" nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" End Section ========================================================

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
set nowritebackup
set noundofile
set swapfile

" Custom fzf stuff:
let g:fzf_layout = { 'down': '~40%' }
nnoremap <silent> <leader>b :FzfBuffers<CR>
" Search by keyword.. hmm
" command! -bang -nargs=* FzfAu call fzf#vim#grep('rg --type py --no-heading --line-number .$ ~/code/', 0)
" nnoremap <silent> <leader>a :FzfAu<CR>
command! -bang -nargs=* FzfProj call fzf#run({'source': 'lsproject', 'left': '30%', 'sink': 'e'})
nnoremap <silent> <leader>n :lcd %:p:h<CR>:FzfProj<CR>

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
" nmap <silent> <C-z> :wincmd q<CR>
" nmap <silent> <C-s> :vsplit<CR>
nmap <silent> <C-h> :wincmd h<CR>
nmap <silent> <C-l> :wincmd l<CR>
nmap X 0D
imap X- X_
imap <f2> <esc>b~ea



" A plugin is unsetting this:
iabbrev +- ±
abbrev ** •
let g:EasyMotion_keys='abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890'

" Fancy movement
" nmap ( <Plug>(IndentWisePreviousLesserIndent)
" nmap ) <Plug>(IndentWiseNextGreaterIndent)
" map <C-[> <Plug>(IndentWisePreviousEqualIndent)
" map <C-]> <Plug>(IndentWiseNextEqualIndent)

" Navigate errors - now done using COC
" nnoremap <silent> <F2> :lprev<CR>
" nnoremap <silent> <F3> :lnext<CR>
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
    " echo "Wrap OFF"
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
    " echo "Wrap ON"
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
