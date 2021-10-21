" Keymaps
nm <Leader>rn <Plug>(coc-rename)

nm <silent> gr <Plug>(coc-references)
nm <silent> gd <Plug>(coc-definition)
nm <silent> gy <Plug>(coc-type-definition)
nm <silent> gi <Plug>(coc-implementation)

nn <silent> <space>c  :<C-u>CocFzfList commands<CR>
nn <silent> <space>l  :<C-u>CocFzfList<CR>

nmap <silent> <C-c> <Plug>(coc-cursors-position)
nmap <silent> <C-d> <Plug>(coc-cursors-word)
xmap <silent> <C-d> <Plug>(coc-cursors-range)

" Coc Extensions
let g:coc_global_extensions = [
  \ 'coc-go',
  \ 'coc-rust-analyzer',
  \ 'coc-pyright',
  \ 'coc-tsserver',
  \ 'coc-vimlsp',
  \ 'coc-html',
  \ 'coc-css',
  \ 'coc-tailwindcss',
  \ 'coc-json',
  \ 'coc-yaml',
  \ 'coc-git',
  \ 'coc-docker',
  \ 'coc-eslint',
  \ 'coc-prettier',
  \ 'coc-snippets',
  \ 'coc-emmet',
  \ ]

" Make coc-fzf same
" as other commands
let g:coc_fzf_preview = ''
let g:coc_fzf_opts = []
