" Runtimepath for fzf
set rtp+=~/.fzf

" Plugins
call plug#begin()

Plug 'lifepillar/vim-solarized8'
Plug 'jiangmiao/auto-pairs'
Plug 'APZelos/blamer.nvim'
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'sheerun/vim-polyglot'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'preservim/nerdcommenter'
Plug 'morhetz/gruvbox'
Plug 'jacoborus/tender.vim'
Plug 'sakhnik/nvim-gdb', { 'do': ':!./install.sh \| UpdateRemotePlugins' }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-rooter'
" Plug 'ahmedkhalf/project.nvim'

" Robot framework stuff
Plug 'totu/robotframework-vim'
" LSP Support
Plug 'neovim/nvim-lspconfig'                           " Required
Plug 'williamboman/mason.nvim', {'do': ':MasonUpdate'} " Optional
Plug 'williamboman/mason-lspconfig.nvim'               " Optional
" Autocompletion
Plug 'hrsh7th/nvim-cmp'     " Required
Plug 'hrsh7th/cmp-nvim-lsp' " Required
Plug 'L3MON4D3/LuaSnip'     " Required

Plug 'VonHeikemen/lsp-zero.nvim', {'branch': 'v2.x'}

call plug#end()

" let g:coc_global_extensions = [
  " \ 'coc-lists',
  " \ 'coc-explorer',
  " \ 'coc-git',
  " \ 'coc-prettier',
  " \ 'coc-json',
  " \ 'coc-tsserver',
  " \ 'coc-rust-analyzer',
  " \ 'coc-rls',
  " \ 'coc-python',
  " \ ]

filetype plugin on
