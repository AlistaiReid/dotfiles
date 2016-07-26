# Path to your oh-my-zsh installation.
export ZSH=/home/areid/.oh-my-zsh
export LC_ALL="en_US.UTF-8"
# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)
#
# User configuration
export PATH="/home/areid/.go:/home/areid/.go/bin:/usr/lib64/qt-3.3/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin:/home/areid/bin"
# export MANPATH="/usr/local/man:$MANPATH"
# use spectrum_ls for codes
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
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi
#
# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

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

# Some terminal specific keybindings 
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line
bindkey '\e[A' history-beginning-search-backward
bindkey '\e[B' history-beginning-search-forward
bindkey ';5C' forward-word
bindkey ';5D' backward-word
bindkey '^[[5~' kill-buffer
bindkey '^[[6~' kill-buffer
bindkey '^[[3~' delete-char

# Keep n lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=5000
SAVEHIST=5000
HISTFILE=~/.zsh_history

# Use modern completion system
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

# Docker stuff
alias dockerkillall='docker kill $(docker ps -q)'
alias dockercleanc='printf "\n>>> Deleting stopped containers\n\n" && docker rm $(docker ps -a -q)'
alias dockercleani='printf "\n>>> Deleting untagged images\n\n" && docker rmi $(docker images -q -f dangling=true)'
alias dockerclean='dockercleanc || true && dockercleani'
# alias somethinglike='cat ~/.zsh_history | grep'
# alias ipython="python3 -c 'import IPython; IPython.terminal.ipapp.launch_new_instance()'"
#plugins=(git)
# alias devmode="source ~/envs/myenv/bin/activate --no-site-packages"
# alias olympic="source ~/envs/olympic/bin/activate --no-site-packages"
# alias clusterous="~/code/clusterous/bin/clusterous"
alias sshc="ssh -i ~/.ssh/clusterous.pem -l ec2-user"
alias sshd="ssh -NL 8890:localhost:8890 -l ubuntu "
alias killworker="ssh -i ~/.ssh/clusterous.pem -l root %1 docker stop $(docker ps -a -q)"
alias p3="ipython3"

alias stash="mv -t ~/tmp/ "

# make linter work all the time!
# alias flake8="/usr/bin/env flake8"

#$PYTHONPATH:
# export PYTHONPATH=/home/areid/code/statbadger:/home/areid/code/BDKD:/home/areid/code/clusterous
# export PROTOCOL_BUFFERS_PYTHON_IMPLEMENTATION=cpp
export GOPATH=/home/areid/.go
export PATH=$GOPATH:$GOPATH/bin:$PATH
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
export WORKON_HOME=~/envs
source /usr/bin/virtualenvwrapper.sh

# Search in python files
alias au="ag -G \".*py$\" "

# Make template python files
alias mk="cp ~/.defaultpy "

# my git config:
# git init --bare $HOME/.myconf
alias config='/usr/bin/git --git-dir=$HOME/.myconf/ --work-tree=$HOME'
alias track='git log --follow --find-renames=60%'

alias git_prune="git branch -vv | grep ': gone]' | awk '{print $1}' | xargs git branch -D"

# config config status.showUntrackedFiles no
# config remote add origin git@github.com:AlistaiReid/dotfiles.git
label Untitled
