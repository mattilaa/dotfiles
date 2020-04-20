" Runtimepath for fzf
set rtp+=~/.fzf

" Plugins
call plug#begin()

Plug 'lifepillar/vim-solarized8'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sheerun/vim-polyglot'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'cloudhead/neovim-fuzzy'
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdcommenter'
Plug 'morhetz/gruvbox'
Plug 'jacoborus/tender.vim'
Plug 'sakhnik/nvim-gdb', { 'do': ':!./install.sh \| UpdateRemotePlugins' }

call plug#end()

let g:coc_global_extensions = [
  \ 'coc-lists',
  \ 'coc-pairs',
  \ 'coc-git',
  \ 'coc-prettier',
  \ 'coc-json',
  \ 'coc-tsserver',
  \ 'coc-rust-analyzer',
  \ 'coc-rls',
  \ 'coc-python',
  \ ]

filetype plugin on
