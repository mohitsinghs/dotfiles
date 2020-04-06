autoload -Uz compinit; compinit
autoload -Uz promptinit; promptinit
PURE_PROMPT_SYMBOL=" "
prompt pure

# enable zsh syntax highlighting and autosuggestions
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# add zsh funtions path
fpath=(/usr/local/Homebrew/completions/zsh/ $fpath)
fpath=(/usr/local/share/zsh-completions $fpath)

# Add homebrew python and ruby to the path
export PATH="/usr/local/opt/python/libexec/bin:$PATH"
export PATH="/usr/local/opt/ruby/bin:$PATH"

# Colorful files
eval `gdircolors -b`

# For the sake of go
export GOPATH="/usr/local/lib/go"
export GOROOT="/usr/local/opt/go/libexec"
export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"

# Test and make directories
test -d "${GOPATH}" || mkdir "${GOPATH}" &> /dev/null
test -d "${GOPATH}/src/github.com" || mkdir -p "${GOPATH}/src/github.com" &> /dev/null

export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8

export FZF_DEFAULT_COMMAND='rg --files'
export FZF_DEFAULT_OPTS='
--info=inline
--color=dark
--color=fg:-1,bg:-1,hl:#c678dd,fg+:#ffffff,bg+:#4b5263,hl+:#d858fe
--color=info:#98c379,prompt:#61afef,pointer:#be5046,marker:#e5c07b,spinner:#61afef,header:#61afef
'
