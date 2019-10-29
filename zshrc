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

export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
