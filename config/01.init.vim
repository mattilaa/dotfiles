filetype off

set termguicolors

let $NVIM_TUI_ENABLE_TRUE_COLOR=1

" Enable syntax highlighting
syntax on

" Fixes backspace
set backspace=indent,eol,start

" Enable line numbers
set number

" Enable relative numbers
set relativenumber

" Enable line/column info at bottom
set ruler

" Autoindentation
set autoindent
filetype indent plugin on

" Copies using system clipboard
set clipboard+=unnamedplus

" Tab = 4 spaces
set tabstop=4
set shiftwidth=4
" set sta
set expandtab
set softtabstop=4 " softtabstop, makes spaces feel like tabs when deleting
set cursorline

" more natural splits
set splitbelow
set splitright

" Editor keymaps
nnoremap <esc><esc> :noh<return>

" For better delete/paste (RIP Larry Tesles)
nnoremap <leader>d "_d
xnoremap <leader>d "_d
xnoremap <leader>p "_dP
nnoremap <C-k> :bp<Cr>
nnoremap <C-l> :bn<Cr>

" Trim trailing whitespaces on save
autocmd BufWritePre * :%s/\s\+$//e

" Ignore case in search
set ignorecase

" Set right margin
set cc=80

set encoding=UTF-8
