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

" For better delete/paste (RIP Larry Tesler)
nnoremap <leader>d "_d
xnoremap <leader>d "_d
xnoremap <leader>p "_dP

" Browse buffers
nnoremap <C-j> :bp<Cr>
nnoremap <C-k> :bn<Cr>
nnoremap <leader>bd :bd<Cr>

" For system clipboard
vnoremap <leader>yj "*y
vnoremap <leader>pj "*p

" Replace visually
set inccommand=nosplit
nnoremap <leader>k :%s/\<<C-r><C-w>\>//gc<Left><Left><Left>

" Trim trailing whitespaces on save
autocmd BufWritePre * :%s/\s\+$//e

" Ignore case in search
set ignorecase

" Set right margin
set cc=80

set encoding=UTF-8

" Disable arrow-keys
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>
