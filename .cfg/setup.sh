# Configure this per system:
sudo apt-get update
alias install="sudo apt-get install"

install git
install zsh

sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

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

sudo chsh -s $(which zsh)

sudo ln -s $HOME/.tools/label /usr/bin
sudo ln -s $HOME/.tools/notebook2py /usr/bin
sudo ln -s $HOME/.tools/custom.zsh-theme $HOME/areid/.oh-my-zsh/custom/themes

