if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

let g:polyglot_disabled = ['coffee-script']

call plug#begin('~/.config/nvim/plugged')

Plug 'joshdick/onedark.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'sheerun/vim-polyglot'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'mohitsinghs/fxyz.vim'

call plug#end()

" Basic
set mouse:a noswf nu rnu ls=0 shm=aIFWc tgc ts=2 sw=2 sts=2 et nofen fenc=utf-8 cb+=unnamedplus ut=300
set wig+=*/.git,*/node_modules,*/venv,*/tmp,*.so,*.swp,*.zip,*.pyc
set list lcs=tab:··,trail:·

" Theme Configs
colo onedark

" Bold and italic in tmux
set t_ZH=[3m
set t_ZR=[23m

" Custom Highlights
hi Comment cterm=italic gui=italic
hi VertSplit ctermbg=bg ctermfg=bg guibg=bg guifg=bg

" Leader
let g:mapleader = ','

" Write and quit keymaps
nn <Leader>q :q<CR>
nn <Leader>w :w<CR>
nn <Leader>ws :noa w<CR>
nn <Leader>wa :wa<CR>
nn <Leader>wtf :w !sudo tee >/dev/null %<CR>

" Git and goyo keymaps
nn <silent> <Leader>df :Goyo<CR>
nn <silent> <Leader>gs :Gstatus<CR>
nn <silent> <Leader>gp :Gpush<CR>
nn <silent> <Leader>gf :Gpush --force<CR>
nn <silent> <Leader>gu :Gpull<CR>

" Coc keymaps
nm <Leader>rn <Plug>(coc-rename)
nm <Leader>gi <Plug>(coc-git-chunkinfo)
nn <silent> <space>c  :<C-u>CocCommand<CR>
nn <silent> <space>l  :<C-u>CocList<CR>

" Fzf keymaps
nn <silent> <space>p  :<C-u>Files<CR>
nn <silent> <space>f  :<C-u>Rg<CR>
nn <silent> <space>g  :<C-u>Commits<CR>

" Fxyz keymaps
nn <silent> <space>r  :<C-u>Repos<CR>
nn <silent> <space>yr  :<C-u>Yr<CR>

" Language tweaks
let g:python3_host_prog = '~/.config/nvim/py3env/bin/python'
let g:javascript_plugin_jsdoc = 1
let g:vim_jsx_pretty_colorful_config = 1
let g:markdown_enable_conceal = 1

" Goyo
aug Goyo
  au! User GoyoEnter Limelight
  au! User GoyoLeave Limelight!
aug END
