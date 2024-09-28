" My .vimrc

" configs {{{
set nocompatible
syntax on
filetype on
filetype plugin on
filetype indent on

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
set history=5000
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx
set clipboard=unnamedplus
" }}}

" plugins {{{
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'joshdick/onedark.vim'
Plug 'lervag/vimtex'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'itchyny/lightline.vim'
Plug 'preservim/vim-markdown'
Plug 'sheerun/vim-polyglot'
call plug#end()

set termguicolors
colorscheme onedark 

set nofoldenable

set laststatus=2
set noshowmode
let g:lightline = { 'colorscheme': 'one' }
" }}}

" mappings {{{
noremap <space> :

let mapleader = " "
let g:mapleader = " "

nnoremap <silent> <leader>b :Buffers<cr>
nnoremap <silent> <leader>x :bd<cr>
nnoremap <silent> <leader>e :edit<space>
nnoremap <silent> <leader>f :Files<cr>

nnoremap <silent> <leader>v :vs<cr>
nnoremap <silent> <leader>h :split<cr>

nnoremap <silent> <leader>s :%s/
nnoremap <silent> <leader>w :w!<cr>
nnoremap <silent> <leader>q :q<cr>
nnoremap <silent> <leader><ESC> :q!<cr>
nnoremap <silent> <C-L> :nohlsearch<cr>

nnoremap <leader>d "_dd

" Move/Copy lines
nnoremap <silent> <M-up> :m .-2<CR>==
nnoremap <silent> <M-down> :m .+1<CR>==
inoremap <silent> <M-up> <Esc>:m .-2<CR>==gi
inoremap <silent> <M-down> <Esc>:m .+1<CR>==gi
vnoremap <silent> <M-up> :m '<-2<CR>gv=gv
vnoremap <silent> <M-down> :m '>+1<CR>gv=gv

" Duplicate lines
nnoremap <silent> <C-S-M-down> :t.<CR>
nnoremap <silent> <C-S-M-up> yyP
" }}}

" autocmd {{{
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}
