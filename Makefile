# Install:
# vim, playstationmediaserver, transmission, openbox

dotfiles := $(realpath .)

all: bashrc vimrc vim pms transmission user-dirs openbox terminator

bashrc: FORCE
	rm -f ~/.bashrc
	ln -s ${dotfiles}/.bashrc ~/.bashrc

vimrc: FORCE
	rm -f ~/.vimrc
	ln -s ${dotfiles}/.vimrc ~/.vimrc

vim: vimrc FORCE
	git submodule update --init --recursive
	rm -f ~/.vim
	ln -s ${dotfiles}/vim ~/.vim
	vim -c "PluginUpdate"

pms: FORCE
	mkdir -p ~/.config/PMS
	rm -f ~/.config/PMS/PMS.conf
	ln -s ${dotfiles}/PMS/PMS.conf ~/.config/PMS/PMS.conf

transmission: FORCE
	mkdir -p ~/.config/transmission
	rm -f ~/.config/transmission/settings.json
	ln -s ${dotfiles}/transmission/settings.json ~/.config/transmission/settings.json

user-dirs: FORCE
	rm -f ~/.config/user-dirs.dirs
	ln -s ${dotfiles}/user-dirs.dirs ~/.config/user-dirs.dirs

openbox: FORCE
	rm -rf ~/.config/openbox
	ln -s ${dotfiles}/openbox ~/.config/openbox

terminator: FORCE
	mkdir -p ~/.config/terminator
	rm -f ~/.config/terminator/config
	ln -s ${dotfiles}/terminator/config ~/.config/terminator/config

FORCE:
