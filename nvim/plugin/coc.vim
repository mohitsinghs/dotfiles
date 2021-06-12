" Keymaps
nm <Leader>rn <Plug>(coc-rename)
nm <Leader>gi <Plug>(coc-git-chunkinfo)
nn <silent> <space>c  :<C-u>CocCommand<CR>
nn <silent> <space>l  :<C-u>CocList<CR>

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

