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

Install the following gnome-shell extensions (as of 3.32):
	Run or Raise
	gtk titlebar
	No topleft hot corner
	removable drive menu
	Simpletray
Gnome tweak tool would be handy here.

Deploy the stored configs by linking out (you may need to delete the originals)
ln .tools/custom.zsh-theme ~/.oh-my-zsh/themes/custom.zsh-theme
ln .tools/shortcuts.conf .local/share/gnome-shell/extensions/run-or-raise@edvard.cz/
sudo cp .tools/smart_embed.py /usr/lib/python3.6 etc...

Put the terminal into undecorated mode
gsettings set org.gnome.Terminal.Legacy.Settings headerbar "@mb false"

get rid of "default" decorations when tiled
copy gtk.css to ~/.config/gtk-3.0/gtk.css
get rid of gtk decorations when tiled

install inconsolata
configue terminal to dark theme, no menu bar, hide scrollbar

*Now you have beautiful undecorated tiling windows with semantic run-or-raise*

Note: these settings work on Gnome Shell 3.32.2. Consider updating, freezing or rollback if they break.

mkdir ~/.vim/swap
enable emoticons through 
sudo pacman -S ttf-bitstream-vera
and maybe ms-fonts?

Font scaling:
gsettings set org.gnome.desktop.interface text-scaling-factor 1.1

Set your mergetool:
git config --global merge.tool meld
```
