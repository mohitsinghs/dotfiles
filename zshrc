autoload -Uz compinit; compinit
autoload -Uz promptinit; promptinit
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
# For the sake of go
export GOPATH="/usr/local/lib/go"
export GOROOT="/usr/local/opt/go/libexec"
export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"
# Test and make directories
test -d "${GOPATH}" || mkdir "${GOPATH}"
test -d "${GOPATH}/src/github.com" || mkdir -p "${GOPATH}/src/github.com"

