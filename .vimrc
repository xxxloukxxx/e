" My .vimrc
" =========

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" configs {{{
set nocompatible

filetype on
filetype plugin on
filetype indent on
syntax enable

set number
set relativenumber
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
    autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
augroup END

set cursorline
set smarttab
set wildmenu wildoptions=pum
set shiftwidth=4
set tabstop=4
set expandtab
set nobackup
set scrolloff=10
set nowrap
set incsearch
set ignorecase
set smartcase
set showcmd
set showmatch
set hlsearch
set timeoutlen=400
set history=5000
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx
set clipboard=unnamedplus
set nofoldenable
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

nnoremap <silent> <leader><ESC><ESC> ZQ

nnoremap <silent> <leader>b :Buffers<cr>
nnoremap <silent> <leader>x :bd!<cr>
nnoremap <silent> <leader>f :Files<cr>

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
nnoremap <silent> <C-S-M-up> yyP

""" Some stuff
nnoremap  ,v :edit   $MYVIMRC<CR>
nnoremap  ,u :source $MYVIMRC<CR>
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
Plug 'Chiel92/vim-autoformat'
Plug 'chrisbra/csv.vim'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/vim-peekaboo'
Plug 'lervag/vimtex'
Plug 'mcchrish/nnn.vim'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'rafi/awesome-vim-colorschemes'
Plug 'ap/vim-css-color'
Plug 'sheerun/vim-polyglot'
Plug 'simnalamburt/vim-mundo'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'w0rp/ale'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'justinmk/vim-sneak'
call plug#end()

""" Colorscheme
set t_Co=256
set termguicolors
colorscheme PaperColor

""" Config for lightline
set laststatus=2
set background=dark
set noshowmode

""" Mapping for Tcomment
nnoremap <silent> <leader>/ :TComment<cr>

""" Config for ALE
nnoremap <silent> <leader>a :ALEToggle<cr>

let g:ale_linters = {
            \  'python': ['ruff'],
            \}

let g:ale_fixers = {
            \  'python': ['black'],
            \  'json': ['prettier'],
            \  'css': ['prettier'],
            \  'markdown': ['prettier'],
            \}
let g:ale_fix_on_save = 0
let g:ale_enabled = 1

""" Config for markdown
let g:vim_markdown_folding_disabled = 1

""" Config for Sneak
let g:sneak#label = 1

""" Config for Coc.nvim
" Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
" delays and poor user experience
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
            \ coc#pum#visible() ? coc#pum#next(1) :
            \ CheckBackspace() ? "\<Tab>" :
            \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
            \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" }}}
