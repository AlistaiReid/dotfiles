# Configure this per system:
sudo apt-get update
alias install="sudo apt-get install"

install git
install zsh

wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O iomz.sh
sudo source iomz.sh

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
pip3 install virtualenvwrapper

sudo chsh -s $(which zsh)
sudo ln -s $HOME/.tools/custom.zsh-theme $HOME/areid/.oh-my-zsh/custom/themes

mkdir $HOME/tmp
