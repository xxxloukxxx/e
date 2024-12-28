" My .vimrc
" =========
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" configs {{{
set encoding=utf-8
scriptencoding utf-8

set nocompatible
set hidden
set nospell
set backspace=indent,eol,start
set autoindent
set autowrite
set autoread

filetype on
filetype plugin on
filetype indent on
syntax on

set number
set relativenumber
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
    autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
augroup END

set cursorline
set ruler
set smarttab
set wildmenu wildoptions=pum
set shiftwidth=4
set tabstop=4
set expandtab
set nobackup
set scrolloff=999
set nowrap
set incsearch
set ignorecase
set smartcase
set showcmd
set showmatch
set hlsearch
set timeoutlen=500
set updatetime=300
set history=5000
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx
set clipboard=unnamedplus
set shortmess+=I
set nofoldenable
" Let's save undo info!
if !isdirectory($HOME."/.vim")
    call mkdir($HOME."/.vim", "", 0770)
endif
if !isdirectory($HOME."/.vim/undo-dir")
    call mkdir($HOME."/.vim/undo-dir", "", 0700)
endif
set undodir=~/.vim/undo-dir
set undofile
set listchars=tab:..,trail:_,extends:>,precedes:<,nbsp:~
set showbreak=\\
set list
set autochdir

" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" autocmd {{{
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" mappings {{{
let mapleader = " "
let g:mapleader = " "

nnoremap j gj
nnoremap k gk

nnoremap <silent> <leader><ESC><ESC> ZQ

nnoremap <silent> <leader>b   :Buffers<cr>
nnoremap <silent> <leader>eur i€<esc>
nnoremap <silent> <leader>m   :w<cr>:make<cr>
nnoremap <silent> <leader>,  :Marks<cr>
nnoremap <silent> <leader>x   :bd!<cr>
nnoremap <silent> <leader>f   :Files<cr>
nnoremap <silent> <leader>t   :term<cr>
nnoremap <silent> <leader>tn  :tabnew<cr>
nnoremap <silent> <leader>tt  :tabnext<cr>

nnoremap <silent> <leader>v :vs<cr>
nnoremap <silent> <leader>h :split<cr>

nnoremap <silent> <leader>w :w!<cr>
nnoremap <silent> <leader>q :q<cr>
nnoremap <silent> <C-L> :nohlsearch<cr>

nnoremap <silent> <leader>d "_dd
nnoremap <silent> <leader>z :set wrap!<cr>

""" Move/Copy lines
nnoremap <silent> <M-up> :m .-2<CR>==
nnoremap <silent> <M-down> :m .+1<CR>==
inoremap <silent> <M-up> <Esc>:m .-2<CR>==gi
inoremap <silent> <M-down> <Esc>:m .+1<CR>==gi
vnoremap <silent> <M-up> :m '<-2<CR>gv=gv
vnoremap <silent> <M-down> :m '>+1<CR>gv=gv

""" Duplicate lines
nnoremap <silent> <C-S-M-down> :t.<CR>
noremap <silent> <C-S-M-up> yyP

""" Some stuff
nnoremap ,v :edit   $MYVIMRC<CR>
nnoremap ,u :source $MYVIMRC<CR>
nnoremap <silent> <leader>af :Autoformat<cr>
nnoremap <leader>s :%s/

nnoremap d "_d
nnoremap c "_c
nnoremap x "_x
nnoremap dd "_dd
inoremap jk <esc>

vnoremap <leader>g :<C-U>!surf "http://www.google.fr/search?hl=fr&q=<cword>" >& /dev/null <CR><CR>
vnoremap <leader>w :<C-U>!surf "http://fr.wikipedia.org/wiki/<cword>" >& /dev/null <CR><CR>
" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" plugins {{{
""" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif
""" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
            \| PlugInstall --sync | source $MYVIMRC
            \| endif

call plug#begin()
Plug 'jacquesbh/vim-showmarks'
Plug 'romainl/vim-qf'
Plug 'Chiel92/vim-autoformat'
Plug 'chrisbra/csv.vim'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-peekaboo'
Plug 'lervag/vimtex'
Plug 'mcchrish/nnn.vim'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'rafi/awesome-vim-colorschemes'
Plug 'ap/vim-css-color'
Plug 'sheerun/vim-polyglot'
Plug 'mbbill/undotree'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'dense-analysis/ale'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

""" Colorscheme{{{
set t_Co=256
set termguicolors
try
    colorscheme PaperColor
catch
    colorscheme default
endtr
" }}}
""" Config for lightline{{{
set laststatus=2
set background=dark
set noshowmode
" }}}
""" Mapping for Tcomment{{{
nnoremap <silent> <leader>/ :TComment<cr>
vnoremap <silent> <leader>/ :TComment<cr>
" }}}
""" Config for markdown{{{
let g:vim_markdown_folding_disabled = 1
" }}}
""" Config for ALE{{{
let g:ale_fixers = {
            \   'markdown': ['prettier'],
            \   'python': ['black'],
            \}

let g:ale_linters = {
            \   'markdown': ['markdownlint'],
            \   'python': ['pylint'],
            \}

let g:ale_python_pylint_options = '--disable=C0114,C0116'
let g:ale_fix_on_save = 1
" }}}
""" Config for Coc {{{
inoremap <silent><expr> <TAB>
            \ coc#pum#visible() ? coc#pum#next(1) :
            \ CheckBackspace() ? "\<Tab>" :
            \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
if has('nvim')
    inoremap <silent><expr> <c-space> coc#refresh()
else
    inoremap <silent><expr> <c-@> coc#refresh()
endif

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')
" }}}


" }}}

"
"
" End of file
