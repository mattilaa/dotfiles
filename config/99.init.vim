filetype off

set termguicolors

let $NVIM_TUI_ENABLE_TRUE_COLOR=1

let g:loaded_clipboard_provider=1

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

" hjkl movement in insert and mode
noremap <A-h> <C-o>h
noremap <A-j> <C-o>j
noremap <A-k> <C-o>k
noremap <A-l> <C-o>l

" Browse buffers
nnoremap <C-j> :bp<Cr>
nnoremap <C-k> :bn<Cr>
nnoremap <leader>bd :bd<Cr>

" For system clipboard
function! ClipboardYank()
  call system('xclip -i -selection clipboard', @@)
endfunction
function! ClipboardPaste()
  let @@ = system('xclip -o -selection clipboard')
endfunction

vnoremap <leader>yj :call ClipboardYank()<cr>
vnoremap <leader>pj :call ClipboardPaste()<cr>
" vnoremap <leader>yj "*y
" vnoremap <leader>pj "*p

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

" Force to enter the real neovim world

" Remove newbie crutches in Command Mode
cnoremap <Down> <Nop>
cnoremap <Left> <Nop>
cnoremap <Right> <Nop>
cnoremap <Up> <Nop>

" Remove newbie crutches in Insert Mode
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>
inoremap <Up> <Nop>

" Remove newbie crutches in Normal Mode
nnoremap <Down> <Nop>
nnoremap <Left> <Nop>
nnoremap <Right> <Nop>
nnoremap <Up> <Nop>

" Remove newbie crutches in Visual Mode
vnoremap <Down> <Nop>
vnoremap <Left> <Nop>
vnoremap <Right> <Nop>
vnoremap <Up> <Nop>

