if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')

Plug 'joshdick/onedark.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'sheerun/vim-polyglot'
Plug 'preservim/nerdtree'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }

call plug#end()

" Basic
set noswf nu rnu ls=0 shm=aIFWc tgc ts=2 sw=2 sts=2 et nofen fenc=utf-8 cb+=unnamedplus ut=300
set wig+=*/.git,*/node_modules,*/venv,*/tmp,*.so,*.swp,*.zip,*.pyc,.DS_Store
set list lcs=tab:··,trail:·

" Theme Configs
colo onedark

" Bold and italic in tmux
set t_ZH=[3m
set t_ZR=[23m

" Italic comments
hi Comment cterm=italic gui=italic
" No vertical split
hi VertSplit ctermbg=bg ctermfg=bg guibg=bg guifg=bg

" Leader
let g:mapleader = ','

" Keymaps
nmap <Leader>gs :Gstatus<CR>
nmap <Leader>gp :Gpush<CR>
nmap <leader>rn <Plug>(coc-rename)
nmap <Leader>gi <Plug>(coc-git-chunkinfo)
nnoremap <silent> <space>n  :<C-u>NERDTreeToggle<CR>
nnoremap <silent> <space>c  :<C-u>CocList commands<CR>
nnoremap <silent> <space>p  :<C-u>CocList files<CR>
nnoremap <silent> <space>f  :<C-u>CocList grep<CR>
nnoremap <silent> <space>l  :<C-u>CocList<CR>

" Language tweaks
let g:javascript_plugin_jsdoc = 1
let g:vim_jsx_pretty_colorful_config = 1
let g:markdown_enable_conceal = 1

" NERDTree
augroup NERDTree
  let g:NERDTreeShowHidden = 1
  let g:NERDTreeStatusline = ''
  let g:NERDTreeRespectWildIgnore = 1
  let NERDTreeDirArrowExpandable = ""
  let NERDTreeDirArrowCollapsible = ""
  let g:NERDTreeAutoDeleteBuffer = v:true
  let g:NERDTreeMinimalUI = v:true
  let g:NERDTreeMinimalMenu = v:true
  let g:NERDTreeNaturalSort = v:true
  autocmd StdinReadPre * let s:std_in=1
  autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
  autocmd FileType nerdtree setlocal conceallevel=3 | syntax match NERDTreeDirSlash #/$# containedin=NERDTreeDir conceal contained
augroup END
