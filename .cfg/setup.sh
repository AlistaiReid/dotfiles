# Configure this per system:
sudo apt-get update
alias install="sudo apt-get install"

install git
install zsh
install nemo
install vim-gtk or nvim???
install curl

if using nvim:
install xsel to enable clipboard integratio
ln -s ~/.vimrc .config/nvim/init.vim
also nvim needs 'pip install neovim' in the path you run nvim from


# for emoji fonts
install ttf-ancient-fonts 
(need symbola, or android emoji font)

# get inconsolata
wget https://github.com/powerline/fonts/blob/master/Inconsolata/Inconsolata%20for%20Powerline.otf?raw=true


sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
# This seems to overwrite my rc files...

# Get my config files
mkdir $HOME/.cfg
echo ".cfg" >> .gitignore
git clone --bare https://github.com/AlistaiReid/dotfiles.git $HOME/.cfg
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
config checkout -f
config config status.showUntrackedFiles no

# If Debian:
install silversearcher-ag
# install dropbox
install python3 python3-pip
sudo pip3 install virtualenvwrapper

install fonts-inconsolata
--- set terminal to use inconsolata

sudo chsh -s $(which zsh)
config checkout ~/.zshrc
mkdir -p $ZSH_CUSTOM/themes
sudo ln -s $HOME/.tools/custom.zsh-theme $ZSH_CUSTOM/themes/

# in case docker isnt installed yet
touch $HOME/.tools/docker
chmod +x $HOME/.tools/docker


mkdir $HOME/tmp
install openssh
install insync
install dropbox
install xorg-xprop
install extnsions pixel-saver and topicons and removable drive menu
configure shortcuts to point to .tools gotoWindow etc for run or raise

systemctl disable dhcpcd
and install networkmanager and network-mananger-applet

# nemo stays resident by making desktop icons
gsettings set org.nemo.desktop show-desktop-icons false


# setting up virtual env:
install tk which provides tk-backend

