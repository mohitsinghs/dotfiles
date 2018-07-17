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
Plug 'tpope/vim-surround'
Plug 'mattn/emmet-vim'
Plug 'othree/html5.vim'
Plug 'posva/vim-vue'
Plug 'tpope/vim-fugitive'

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
colorscheme custom

map <C-S-tab> :tabprevious<CR>
map <C-tab>   :tabnext<CR>
map <C-t>     :tabnew<CR>
map <tab>     :bnext<CR>
map <S-tab>   :bprevious<CR>

let g:user_emmet_expandabbr_key= '<c-e>'
let g:airline_theme='molokai'
let g:airline#extensions#tabline#enabled = 1
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
