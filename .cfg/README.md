# INSTALL Guide
```
ssh-keygen
...add key to github
pacin zsh
install oh-my-zsh
git init --bare $HOME/.cfg
cd .cfg
git remote add origin git@github.com:AlistaiReid/dotfiles.git
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
cd ~
config reset --hard origin/master
git config user.email "alistair.reid@gmail.com"
Install run-or-raise gnome shell extension

ln .tools/custom.zsh-theme ~/.oh-my-zsh/themes/custom.zsh-theme
ln .tools/shortcuts.conf .local/share/gnome-shell/extensions/run-or-raise@edvard.cz/
sudo cp .tools/smart_embed.py /usr/lib/python3.6 etc...
```
