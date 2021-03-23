if !has('unix')
  echoerr "only unix is supported"
  finish
endif

if !executable('rg')
  echoerr "ripgrep must be installed"
  finish
endif

" Set ripgrep as fzf command
let $FZF_DEFAULT_COMMAND='rg --files'

" Set color scheme to one dark
let $FZF_DEFAULT_OPTS='
  \ --info=inline
  \ --layout=reverse
  \ --color=dark
  \ --color=fg:-1,bg:-1,hl:#c678dd,fg+:#ffffff,bg+:#4b5263,hl+:#d858fe
  \ --color=info:#98c379,prompt:#61afef,pointer:#be5046,marker:#e5c07b,spinner:#61afef,header:#61afef'

" Hide mode for fzf
autocmd! FileType fzf set nosmd | autocmd BufLeave <buffer> set smd


if !exists('g:fim_roots')
  let g:fim_roots = ["~/Projects"]
endif

let s:find_cmd = "find ". join(g:fim_roots," ") .' -type d'

function s:ChangeRoot(item)
  let path = split(a:item[0], '⟶')
  execute('cd '.path[1])
endfunction

" Switch between Projects 
let repos_options = {
  \ 'source' : s:find_cmd . ' | rg ''([\s\S]*)/([^/]*)/.git$'' -r ''[33m$2[0m ⟶ $1/$2''',
  \ 'sink*' : function('s:ChangeRoot'),
  \ 'options': '--ansi --prompt ''Projects >'''
  \ }

" Define our commands
command! Repos call fzf#run(fzf#wrap(repos_options))
