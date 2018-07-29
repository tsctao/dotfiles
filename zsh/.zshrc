HISTFILE=~/.histfile
HISTSIZE=5000
SAVEHIST=5000
DIRSTACKSIZE=8

setopt auto_pushd           # cd pushes directory to the stack
setopt pushd_ignore_dups
setopt extended_glob
setopt interactive_comments # allow comments in interactive shell
setopt inc_append_history   # add new history to the file immediately
setopt share_history        # share history across all sessions
setopt hist_ignore_dups
setopt hist_ignore_all_dups # remove older duplicated history
setopt hist_ignore_space    # ignore history with leading space
setopt hist_verify          # don't execute history immediately

bindkey -v # vi mode
export KEYTIMEOUT=1 # change vi mode faster (10ms)

bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
bindkey '^[[Z' reverse-menu-complete

export LSCOLORS='BxexfxfxcxdxdxdxdxDxDx' # Colorize ls
export GREP_COLOR='7;34'                 # Colorize grep
# ls colors for GNU
export LS_COLORS='di=1;31:ln=34:so=35:pi=35:ex=32:bd=33:cd=33:su=33:sg=33:tw=1;33:ow=1;33'

# Colorize less (man page)
export LESS_TERMCAP_mb=$'\E[1;31m' # begin blinking
export LESS_TERMCAP_md=$'\E[1;31m' # begin bold
export LESS_TERMCAP_me=$'\E[0m'    # end mode
export LESS_TERMCAP_se=$'\E[0m'    # end standout mode
export LESS_TERMCAP_so=$'\E[7m'    # begin standout mode
export LESS_TERMCAP_ue=$'\E[0m'    # end underline
export LESS_TERMCAP_us=$'\E[1;32m' # begin underline

# Load completions
fpath=(~/.zsh/completions /usr/local/share/zsh-completions $fpath)
autoload -Uz compinit
compinit -C -d ~/.zcompdump

# Completion styles
zstyle ':completion:*:*:*:*:*' menu 'select'    # always use menu with select
zstyle ':completion:*' \
  matcher-list 'm:{a-zA-Z}={A-Za-z}' '+r:|?=**' # case-insensitive and partial matching
zstyle ':completion:*' group-name ''            # group matches
zstyle ':completion:*:descriptions' \
  format '%F{green}%B[%d]%b%f'                  # colorize group name
zstyle ':completion:*:messages' \
  format '%F{red}%B%d%b%f'                      # colorize _message
zstyle ':completion:*:warnings' \
  format '%F{red}%Bno completion found!%b%f'    # show no completion message
zstyle ':completion:*:default' \
  list-colors "${(s.:.)LS_COLORS}"              # colorize files and directories
zstyle ':completion::complete:*' use-cache on
zstyle ':completion:*:functions' \
  ignored-patterns '_*'                         # don't complete some commands
zstyle ':completion:*:(rm|kill|diff):*' \
  ignore-line other                             # ignore selected entries for these commands

# Load syntax highlighting
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

# Load Fish-like history search
source /usr/local/share/zsh-history-substring-search/zsh-history-substring-search.zsh
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='bg=green,fg=white'
export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND=''

# Load functions
fpath=(~/.zsh/functions $fpath)
for function in ~/.zsh/functions/*; do
  autoload -Uz $function
done

# Load aliases
[[ -f ~/.aliases ]] && source ~/.aliases

# pyenv (Python Version Management)
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# Pure prompt
fpath=(~/.zsh/pure $fpath)
autoload -U promptinit
promptinit
prompt pure
