# Configure this per system:
sudo apt-get update
alias install="sudo apt-get install"

install git
install zsh
install nemo
install vim-gtk

wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O iomz.sh
bash iomz.sh
# This seems to overwrite my rc files

# Get my config files
mkdir $HOME/.cfg
echo ".cfg" >> .gitignore
git clone --bare https://github.com/AlistaiReid/dotfiles.git $HOME/.cfg
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
config checkout
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
