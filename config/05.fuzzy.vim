" Keymap for fzy
nnoremap <C-p> :FuzzyOpen<CR>
nnoremap <C-s> :FuzzyGrep<CR>

set wildignore+=*.o,*.o2,./git/**,*.os

" Settings for fzf
nnoremap <Leader>ff :Files<CR>
nnoremap <Leader>fg :GFiles<CR>

" use the silver searcher
 let g:agprg="ag -i --vimgrep"
 let g:ag_highlight=1
 " map \ to the ag command for quick searching
" nnoremap <Leader>\ :Ag<SPACE>

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always -i '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)


command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, {'options': ['--layout=reverse', '--info=inline', '--preview', '~/.config/nvim/plugged/fzf.vim/bin/preview.sh {}']}, <bang>0)

command! -bang -nargs=? -complete=dir GFiles
    \ call fzf#vim#files(<q-args>, {'options': ['--layout=reverse', '--info=inline', '--preview', '~/.config/nvim/plugged/fzf.vim/bin/preview.sh {}']}, <bang>0)

