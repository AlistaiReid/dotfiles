# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
export LC_ALL="en_US.UTF-8"
export PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin:/usr/bin/core_perl"
plugins=(git)


# oh-my-zsh setup ------------------------
# CASE_SENSITIVE="true"
# HYPHEN_INSENSITIVE="true"
# DISABLE_AUTO_UPDATE="true"
# export UPDATE_ZSH_DAYS=13
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

# Completion system
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
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias vim='vimx'
alias ccat='pygmentize'

alias gitgg='git log --oneline --decorate --graph --all'

# Docker shortcuts
alias dockerkillall='docker kill $(docker ps -q)'
alias dockercleanc='printf "\n>>> Deleting stopped containers\n\n" && docker rm $(docker ps -a -q)'
alias dockercleani='printf "\n>>> Deleting untagged images\n\n" && docker rmi $(docker images -q -f dangling=true)'
alias dockerclean='dockercleanc || true && dockercleani'
# alias somethinglike='cat ~/.zsh_history | grep'
# alias ipython="python3 -c 'import IPython; IPython.terminal.ipapp.launch_new_instance()'"
# alias sshc="ssh -i ~/.ssh/aws.pem -l ec2-user"

# Handy shortcuts
alias stash="mv -t ~/tmp/ "
alias au="ag -G \".*py$\" "  # search in python files
export PATH=$HOME/.tools:$PATH

# Python virtual envs
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
export WORKON_HOME=~/.envs
source $(which virtualenvwrapper.sh)


# Make template python files
alias mk="cp ~/.defaultpy "

# my git config:
# git init --bare $HOME/.cfg
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias track='git log --follow --find-renames=60%'

alias git-prune="git fetch --prune && git branch -vv | grep ': gone]' | awk '{print \$1}' | xargs -r git branch -D"
# alias gitfeature="git fetch && echo git push origin origin/develop:feature/\#(trim $1)"

alias pipupg="pip install -U pip && pip freeze | grep -v 'git' | cut -d = -f 1 | xargs -n1 pip install -U"
# list --outdated | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U"


alias pacall="LC_ALL=C pacman -Qi | sed -n '/^Name[^:]*: \(.*\)/{s//\1 /;x};/^Installed[^:]*: \(.*\)/{s//\1/;H;x;s/\n//;p}' | sort -nk2 | column -t"
alias pacupg='pacaur -Syu' # Synchronize with repositories before upgrading packages that are out of date on the local system.
alias pacin='pacaur -S' # Install specific package(s) from the repositories
alias pacins='sudo pacman -U' # Install specific package not from the repositories but from a file
alias pacre='pacaur -R' # Remove the specified package(s), retaining its configuration(s) and required dependencies
alias pacrem='pacaur -Rns' # Remove the specified package(s), its configuration(s) and unneeded dependencies
alias pacinf='pacaur -Si' # Display information about a given package in the repositories
alias pacs='pacaur -Ss' # Search for package(s) in the repositories
alias pacloc='pacaur -Qi' # Display information about a given package in the local database
alias pacfiles='pacaur -Ql' # list the files from a certain pacagke
alias paclocs='pacaur -Qs' # Search for package(s) in the local database
alias pacupd='sudo pacman -Sy' # Update and refresh the local package and ABS databases against repositories
alias pacinsd='sudo pacman -S --asdeps' # Install given package(s) as dependencies of another package
alias pacmir='sudo pacman -Syy' # Force refresh of all package lists after updating /etc/pacman.d/mirrorlist Created by newuser for 5.2

# Get kubectl auto-completion stuff!
# source <(kubectl completion zsh)

# Git flow completion:
source ~/.tools/git-flow-completion/git-flow-completion.zsh

# config config status.showUntrackedFiles no
# config remote add origin git@github.com:AlistaiReid/dotfiles.git
export LD_LIBRARY_PATH=/opt/cuda/lib64/

export MYPYPATH=/home/areid/code/stubs

# Get rid of extensive tensorflow logging.
export TF_CPP_MIN_LOG_LEVEL=3

label Untitled
workon tensorflow
# do something with $PWD

alias debug='tee --output-error > ~/.py_link | python'  # run python, duplicating stdin to vim connection
