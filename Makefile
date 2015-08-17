# Install:
# vim, playstationmediaserver, transmission, openbox

all: bashrc vimrc vim pms transmission user-dirs openbox terminator

bashrc: FORCE
	rm ~/.bashrc
	ln -s ~/dotfiles/.bashrc ~/.bashrc

vimrc: FORCE
	rm ~/.vimrc
	ln -s ~/dotfiles/.vimrc ~/.vimrc

vim: FORCE
	git submodule update --init --recursive ~/dotfiles/vim/bundle/
	ln -s ~/dotfiles/vim ~/.vim
	rm ~/dotfiles/vim/vim # No idea why I need this!

pms: FORCE
	mkdir -p ~/.config/PMS
	ln -s ~/dotfiles/PMS/PMS.conf ~/.config/PMS/PMS.conf

transmission: FORCE
	rm ~/.config/transmission/settings.json
	ln -s ~/dotfiles/transmission/settings.json ~/.config/transmission/settings.json

user-dirs: FORCE
	rm ~/.config/user-dirs.dirs
	ln -s ~/dotfiles/user-dirs.dirs ~/.config/user-dirs.dirs

openbox: FORCE
	rm -r ~/.config/openbox
	ln -s ~/dotfiles/openbox ~/.config/openbox

terminator: FORCE
	rm ~/.config/terminator/config
	ln -s ~/dotfiles/terminator/config ~/.config/terminator/config

FORCE:
