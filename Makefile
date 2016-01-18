dotfiles := $(realpath .)

all: bashrc vim conky user-dirs openbox volti tint2 xscreensaver terminator pms transmission

bashrc: FORCE
	rm -f ~/.bashrc
	ln -s ${dotfiles}/bashrc ~/.bashrc

vimrc: FORCE
	rm -f ~/.vimrc
	ln -s ${dotfiles}/vimrc ~/.vimrc

vim: vimrc FORCE
	git submodule update --init --recursive
	cd vim/bundle/Vundle.vim && git checkout master
	rm -f ~/.vim
	ln -s ${dotfiles}/vim ~/.vim
	vim -c "PluginUpdate"

conky: FORCE
	rm -f ~/.conkyrc
	ln -s ${dotfiles}/conkyrc ~/.conkyrc

user-dirs: FORCE
	rm -f ~/.config/user-dirs.dirs
	ln -s ${dotfiles}/user-dirs.dirs ~/.config/user-dirs.dirs

openbox: FORCE
	rm -rf ~/.config/openbox
	ln -s ${dotfiles}/openbox ~/.config/openbox

volti: FORCE
	rm -rf ~/.config/volti/config
	ln -s ${dotfiles}/volti/config ~/.config/volti/config

tint2: FORCE
	rm -rf ~/.config/tint2/tint2rc
	ln -s ${dotfiles}/tint2rc ~/.config/tint2/tint2rc

xscreensaver: FORCE
	rm -f ~/.xscreensaver
	ln -s ${dotfiles}/xscreensaver ~/.xscreensaver

terminator: FORCE
	mkdir -p ~/.config/terminator
	rm -f ~/.config/terminator/config
	ln -s ${dotfiles}/terminator/config ~/.config/terminator/config

pms: FORCE
	mkdir -p ~/.config/PMS
	rm -f ~/.config/PMS/PMS.conf
	ln -s ${dotfiles}/PMS/PMS.conf ~/.config/PMS/PMS.conf

transmission: FORCE
	mkdir -p ~/.config/transmission
	rm -f ~/.config/transmission/settings.json
	ln -s ${dotfiles}/transmission/settings.json ~/.config/transmission/settings.json

FORCE:
