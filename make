# Install:
# vim, playstationmediaserver, terminator, transmission, openbox

ln -s ~/dotfiles/.bashrc ~/.bashrc
ln -s ~/dotfiles/.vimrc ~/.vimrc
ln -s ~/dotfiles/PMS/PMS.conf ~/.config/PMS/PMS.conf
ln -s ~/dotfiles/terminator/config ~/.config/terminator/config
ln -s ~/dotfiles/transmission/settings.json ~/.config/transmission/settings.json
ln -s ~/dotfiles/user-dirs.dirs ~/.config/user-dirs.dirs
ln -s ~/dotfiles/monitors.xml ~/.config/monitors.xml
git submodule update --init --recursive ~/dotfiles/vim/bundle/
ln -s ~/dotfiles/vim ~/.vim
rm ~/dotfiles/vim/vim # No idea why I need this!
