# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
export LC_ALL="en_US.UTF-8"
source ~/.private

# oh-my-zsh setup ------------------------
# CASE_SENSITIVE="true"
# HYPHEN_INSENSITIVE="true"
# DISABLE_AUTO_UPDATE="true"
export UPDATE_ZSH_DAYS=14
# DISABLE_LS_COLORS="true"
DISABLE_AUTO_TITLE="true"
# ENABLE_CORRECTION="true"
# COMPLETION_WAITING_DOTS="true"
# DISABLE_UNTRACKED_FILES_DIRTY="true"
ZSH_THEME="custom"
BULLETTRAIN_PROMPT_CHAR=":"
BULLETTRAIN_STATUS_SHOW=true
BULLETTRAIN_VIRTUALENV_BG=022
BULLETTRAIN_PROMPT_ADD_NEWLINE=false
BULLETTRAIN_TIME_SHOW=false
BULLETTRAIN_PROMPT_SEPARATE_LINE=true
BULLETTRAIN_NVM_SHOW=false
BULLETTRAIN_DIR_BG=024
BULLETTRAIN_GIT_BG=248
BULLETTRAIN_RUBY_SHOW=false
BULLETTRAIN_HG_SHOW=false
source $ZSH/oh-my-zsh.sh
unsetopt AUTO_CD

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='gvim'
fi
# Set up the prompt
# autoload -Uz promptinit
# promptinit
# prompt="%~: "
# #prompt redhat
# RPROMPT="%n" # "%n@%m"
# #"%F{${1:-green}}%~%p"
# autoload -U colors
# colors
RPROMPT=""
setopt histignorealldups sharehistory

# Some terminal specific keybindings  - maybe need per machine adjustment
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line
bindkey '\e[A' history-beginning-search-backward
bindkey '\e[B' history-beginning-search-forward
bindkey ';5C' forward-word
bindkey ';5D' backward-word
bindkey '^[[5~' kill-buffer
bindkey '^[[6~' kill-buffer
bindkey '^[[3~' delete-char

# get matplotlib working
export MPLBACKEND=TKAGG

# Keep n lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

# Completion system [TODO: review]
autoload -Uz compinit
compinit
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# pretty colours
alias grep='grep --color=auto'
alias vim='vimx'
alias ccat='pygmentize'
alias ag='ag -a'

# Git shortcuts
alias gitgg='git log --oneline --decorate --graph --all'
alias track='git log --follow --find-renames=60%'

# Docker shortcuts
alias dockerkillall='docker kill $(docker ps -q)'
alias dockercleanc='printf "\n>>> Deleting stopped containers\n\n" && docker rm $(docker ps -a -q)'
alias dockercleani='printf "\n>>> Deleting untagged images\n\n" && docker rmi $(docker images -q -f dangling=true)'
alias dockerclean='dockercleanc || true && dockercleani'

# Python virtual envs with virtualenvwrapper
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
export WORKON_HOME=~/.envs
# hotfix egrep warning (when will they fix this?)
source $(which virtualenvwrapper.sh) &> /dev/null

# Some ML stuff
export TF_CPP_MIN_LOG_LEVEL=3
export GCP_ZONE="australia-southeast1-b"

# Admin tools ------------------------------------
# function for displaying scripts in path without finding them first
showme(){
    which "$1"
    which "$1" | xargs cat | more
}
#
# Housekeeping shortcuts
alias stash="mv -t ~/tmp/ "
alias au="ag -G \".*py$\" "  # search in python files

# Add my custom tools to path
export PATH=$HOME/.tools:$PATH

# Various aliases -------------------------------
alias gvim='gvim --remote-silent'
alias cat="bat"
alias tree="lsd --tree --icon never"
alias pacfreeze="LC_ALL=C pacman -Qi | sed -n '/^Name[^:]*: \(.*\)/{s//\1 /;x};/^Installed[^:]*: \(.*\)/{s//\1/;H;x;s/\n//;p}' | sort -nk2 | column -t"
alias pacupg='sudo pacman -Syu --noconfirm && yay'
alias pacin='sudo -v && yay -S --noconfirm' # Install specific package(s) from the repositories
alias pacre='yay -Rc' # Remove the specified package(s), retaining its configuration(s) and required dependencies
alias pacrm='yay -Rns' # Remove the specified package(s), its configuration(s) and unneeded dependencies
alias pacinf='yay -Si' # Display information about a given package in the repositories
alias pacs='yay -Ss' # Search for package(s) in the repositories
alias pacfiles='yay -Ql' # list the files from a certain pacagke
# Attempt to update all the packages in a pip env
alias pipupg="pip install -U pip && pip freeze | grep -v 'git' | cut -d = -f 1 | xargs -n1 pip install -U"
# my configuration is tracked in git with root being home:
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# Finishing touches
label Untitled
export QT_AUTO_SCREEN_SCALE_FACTOR=1
cd ~
stty intr ^C 
