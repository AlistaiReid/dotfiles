# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
export LC_ALL="en_US.UTF-8"
export PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin"
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

# Keep n lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=5000
SAVEHIST=5000
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
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
export WORKON_HOME=~/.envs
source /usr/bin/virtualenvwrapper.sh


# Make template python files
alias mk="cp ~/.defaultpy "

# my git config:
# git init --bare $HOME/.cfg
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias track='git log --follow --find-renames=60%'

alias git_prune="git branch -vv | grep ': gone]' | awk '{print $1}' | xargs git branch -D"

# config config status.showUntrackedFiles no
# config remote add origin git@github.com:AlistaiReid/dotfiles.git
label Untitled
