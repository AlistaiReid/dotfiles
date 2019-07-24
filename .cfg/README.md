# HOW TO INSTALL

```
ssh-keygen
...add to github
git init --bare $HOME/.cfg
cd .cfg
git remote add origin git@github.com:AlistaiReid/dotfiles.git
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
cd ~
config reset --hard origin/master
git config user.email "alistair.reid@gmail.com"
```
