for f in split(glob('~/.config/nvim/config/*.vim'), '\n')
        exe 'source' f
endfor

let g:loaded_clipboard_provider = 1
