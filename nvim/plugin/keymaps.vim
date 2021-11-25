" Leader
let g:mapleader = ','

" Write and quit
nn <Leader>q :q<CR>
nn <Leader>w :w<CR>
nn <Leader>ws :noa w<CR>
nn <Leader>wa :wa<CR>
nn <Leader>wtf :w !sudo tee >/dev/null %<CR>

" Git
nn <silent> <Leader>gs :Git<CR>
nn <silent> <Leader>gp :Git push<CR>
nn <silent> <Leader>gf :Git push --force<CR>
nn <silent> <Leader>gu :Git pull<CR>

" Fzf lists
nn <silent> <space>p  :<C-u>Files<CR>
nn <silent> <space>f  :<C-u>Rg<CR>
nn <silent> <space>g  :<C-u>Commits<CR>
nn <silent> <space>r  :<C-u>Repos<CR>

" Some lsp specfic keymaps
nm <silent> <Leader>rn <Plug>(coc-rename)
nm <silent> gr <Plug>(coc-references)
nm <silent> gd <Plug>(coc-definition)
nm <silent> gy <Plug>(coc-type-definition)
nm <silent> gi <Plug>(coc-implementation)

" Coc lists with fzf
nn <silent> <space>c  :<C-u>CocFzfList commands<CR>
nn <silent> <space>l  :<C-u>CocFzfList<CR>

" Multiple cursors
nm <silent> <C-c> <Plug>(coc-cursors-position)
xm <silent> <C-d> <Plug>(coc-cursors-range)
nmap <Leader>x  <Plug>(coc-cursors-operator)
nmap <expr> <silent> <C-d> <SID>select_current_word()
function! s:select_current_word()
  if !get(b:, 'coc_cursors_activated', 0)
    return "\<Plug>(coc-cursors-word)"
  endif
  return "*\<Plug>(coc-cursors-word):nohlsearch\<CR>"
endfunc
