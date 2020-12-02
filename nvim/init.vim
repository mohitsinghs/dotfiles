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
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

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

" Coc keymaps
nm <Leader>rn <Plug>(coc-rename)
nm <Leader>gi <Plug>(coc-git-chunkinfo)
nn <silent> <space>c  :<C-u>CocCommand<CR>
nn <silent> <space>l  :<C-u>CocList<CR>

" Fzf keymaps
nn <silent> <space>p  :<C-u>Files<CR>
nn <silent> <space>f  :<C-u>Rg<CR>

" Language tweaks
let g:python3_host_prog = '~/.config/nvim/py3env/bin/python'
let g:javascript_plugin_jsdoc = 1
let g:vim_jsx_pretty_colorful_config = 1
let g:markdown_enable_conceal = 1

" minmal and better fzf layout
let $FZF_DEFAULT_COMMAND='rg --files'
let $FZF_DEFAULT_OPTS='
      \ --info=inline
      \ --color=dark
      \ --color=fg:-1,bg:-1,hl:#c678dd,fg+:#ffffff,bg+:#4b5263,hl+:#d858fe
      \ --color=info:#98c379,prompt:#61afef,pointer:#be5046,marker:#e5c07b,spinner:#61afef,header:#61afef'
let $FZF_DEFAULT_OPTS .= ' --layout=reverse'

" ripgrep integration
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

" ripgrep command
com! -nargs=* -bang Rg call RipgrepFzf(<q-args>, <bang>0)

" clean fzf
au! FileType fzf set nosmd nonu nornu | au BufLeave <buffer> set smd nu rnu

" Goyo
aug Goyo
  au! User GoyoEnter Limelight
  au! User GoyoLeave Limelight!
aug END
