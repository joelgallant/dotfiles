# Install:
# vim, playstationmediaserver, terminator, transmission, openbox

rm ~/.bashrc
ln -s ~/dotfiles/.bashrc ~/.bashrc
rm ~/.vimrc
ln -s ~/dotfiles/.vimrc ~/.vimrc
ln -s ~/dotfiles/PMS/PMS.conf ~/.config/PMS/PMS.conf
rm ~/.config/terminator/config
ln -s ~/dotfiles/terminator/config ~/.config/terminator/config
rm ~/.config/transmission/settings.json
ln -s ~/dotfiles/transmission/settings.json ~/.config/transmission/settings.json
rm ~/.config/user-dirs.dirs
ln -s ~/dotfiles/user-dirs.dirs ~/.config/user-dirs.dirs
rm ~/.config/monitors.xml
ln -s ~/dotfiles/monitors.xml ~/.config/monitors.xml
git submodule update --init --recursive ~/dotfiles/vim/bundle/
ln -s ~/dotfiles/vim ~/.vim
rm ~/dotfiles/vim/vim # No idea why I need this!
rm -r ~/.config/openbox
ln -s ~/dotfiles/openbox ~/.config/openbox
