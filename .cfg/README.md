# HOW TO INSTALL

```
git init --bare $HOME/.cfg
cd .cfg
git remote add origin https://github.com/AlistaiReid/dotfiles.git
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
cd ~
config reset --hard origin/master
git config user.email "alistair.reid@gmail.com"
```
