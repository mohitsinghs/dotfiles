let g:os = substitute(system('uname'), '\n', '', '')

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'junegunn/vim-easy-align'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'pangloss/vim-javascript'
Plug 'leshill/vim-json'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-surround'
Plug 'mxw/vim-jsx'
Plug 'mattn/emmet-vim'
Plug 'othree/html5.vim'
if g:os == 'Darwin'
  Plug 'tpope/vim-fugitive'
  Plug 'edkolev/tmuxline.vim'
  Plug 'christoomey/vim-tmux-runner'
endif

call plug#end()

set laststatus=2
syntax on
set number
set mouse:a
filetype plugin indent on
set tabstop=2 shiftwidth=2 expandtab
set backspace=indent,eol,start
set encoding=utf-8
set fileencoding=utf-8
set termguicolors
colorscheme monokai_pro

map <C-S-tab> :tabprevious<CR>
map <C-tab>   :tabnext<CR>
map <C-t>     :tabnew<CR>
map <tab>     :bnext<CR>
map <S-tab>   :bprevious<CR>
map <C-b>     :NERDTreeToggle<CR>

let g:user_emmet_expandabbr_key= '<c-e>'
let g:airline_theme='molokai'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tmuxline#enabled = 1
let g:airline#extensions#ale#enabled = 1
if g:os == 'Linux'
  let g:airline_mode_map = {
      \ '__' : '-',
      \ 'n'  : 'N',
      \ 'i'  : 'I',
      \ 'R'  : 'R',
      \ 'c'  : 'C',
      \ 'v'  : 'V',
      \ 'V'  : 'V',
      \ '' : 'V',
      \ 's'  : 'S',
      \ 'S'  : 'S',
      \ '' : 'S',
      \ 't'  : 'T',
  \ }
endif
let g:javascript_plugin_jsdoc = 1
let g:jsx_ext_required= 1
let g:NERDTreeDirArrowExpandable="~"
let g:NERDTreeDirArrowCollapsible="~"
let g:NERDTreeShowHidden = v:true
let g:NERDTreeAutoDeleteBuffer = v:true
let g:NERDTreeMinimalUI = v:true
let g:NERDTreeNaturalSort = v:true

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
autocmd FileType nerdtree setlocal conceallevel=3 | syntax match NERDTreeDirSlash #/$# containedin=NERDTreeDir conceal contained
