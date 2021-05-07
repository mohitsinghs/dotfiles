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

" Fzf
nn <silent> <space>p  :<C-u>Files<CR>
nn <silent> <space>f  :<C-u>Rg<CR>
nn <silent> <space>g  :<C-u>Commits<CR>
nn <silent> <space>r  :<C-u>Repos<CR>

