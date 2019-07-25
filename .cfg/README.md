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

Put the terminal into undecorated mode
gsettings set org.gnome.Terminal.Legacy.Settings headerbar "@mb false"

get rid of "default" decorations when tiled
copy gtk.css to ~/.config/gtk-3.0/gtk.css
get rid of gtk decorations when tiled
pacin gnome-shell-extension-gtktitlebar-git

install inconsolata
configue terminal to dark theme, no menu bar, hide scrollbar

*Now you have beautiful undecorated tiling windows with semantic run-or-raise*

Note: these settings work on Gnome Helln 3.32.2. Consider updating, freezing or rollback if they break.

```
