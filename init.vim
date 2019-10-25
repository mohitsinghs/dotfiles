if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')

Plug 'cocopon/iceberg.vim'
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdcommenter'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'ryanoasis/vim-devicons'
Plug 'scrooloose/nerdtree'
Plug 'sheerun/vim-polyglot'
Plug 'mohitsinghs/vim-jinja'

call plug#end()

" Basic
filetype plugin indent on
set nu rnu ls=0 shm=aIFWc tgc mouse:a ts=2 sw=2 sts=2 et nofen fenc=utf-8 cb=unnamedplus
set wig+=*/.git,*/node_modules,*/tmp,*.so,*.swp,*.zip,*.pyc,.DS_Store
set list lcs=tab:»·,trail:·
let g:polyglot_disabled = ['jinja']

" Theme Config
colo iceberg

" Bold and italic in tmux
set t_ZH=[3m
set t_ZR=[23m

" Italic comments
hi Comment cterm=italic gui=italic
" No vertical split
hi VertSplit ctermbg=bg ctermfg=bg guibg=bg guifg=bg

" Keynmaps
let g:mapleader = ','
nmap <Leader>[ :bp<CR>
nmap <Leader>] :bn<CR>
nmap <Leader>w :bd<CR>
nmap <Leader>p :CocList files<CR>
nmap <Leader>rn <Plug>(coc-rename)
nmap <Leader>b :NERDTreeToggle<CR>

" Moving single lines
nnoremap <A-Up> :m .-2<CR>==
nnoremap <A-Down> :m .+1<CR>==
inoremap <A-Up> <Esc>:m .-2<CR>==gi
inoremap <A-Down> <Esc>:m .+1<CR>==gi
vnoremap <A-Up> :m '>-2<CR>gv=gv
vnoremap <A-Down> :m '<+1<CR>gv=gv

" Multiple cursors
nmap <silent> <C-c> <Plug>(coc-cursors-position)
nmap <expr> <silent> <C-d> <SID>select_current_word()
function! s:select_current_word()
  if !get(g:, 'coc_cursors_activated', 0)
    return "\<Plug>(coc-cursors-word)"
  endif
  return "*\<Plug>(coc-cursors-word):nohlsearch\<CR>"
endfunc

" JavaScript and JSX
let g:javascript_plugin_jsdoc = 1
let g:vim_jsx_pretty_colorful_config = 1
let g:vim_markdown_frontmatter = 1

" Devicons
let g:WebDevIconsOS = 'Darwin'
let g:webdevicons_enable_nerdtree = 0

" Airline
let g:airline_powerline_fonts = 1
let g:airline_skip_empty_sections = 1
let g:airline_left_sep = ' '
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ' '
let g:airline_right_alt_sep = ''
let g:airline_symbols = { 'branch' : '' }
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'

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

" Using CocList
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
nnoremap <silent> <space>l  :<C-u>CocList<cr>
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" Completion
augroup Completion
  function! s:expand()
    if pumvisible()
      return "\<C-y>"
    endif
    let col = col('.') - 1
    if !col || getline('.')[col - 1]  =~# '\s'
      return "\<Tab>"
    endif
    return "\<A-x>\<A-e>"
  endfunction
  " Close preview window after completion is done
  autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
  " Use <Tab> for confirm completion.
  imap <silent><expr> <Tab> <SID>expand()
augroup END

