dotfiles := $(realpath .)

all: bashrc tmux vim git conky user-dirs openbox volti tint2 xscreensaver terminator pms transmission

bashrc: FORCE
	rm -f ~/.bashrc
	ln -s ${dotfiles}/bashrc ~/.bashrc

tmux: FORCE
	rm -f ~/.tmux.conf
	ln -s ${dotfiles}/tmux.conf ~/.tmux.conf
	git submodule update --init --recursive tpm/
	cd tpm && git checkout master
	mkdir -p ~/.tmux/plugins
	rm -rf ~/.tmux/plugins/tpm
	ln -s ${dotfiles}/tpm ~/.tmux/plugins/tpm

vimrc: FORCE
	rm -f ~/.vimrc
	ln -s ${dotfiles}/vimrc ~/.vimrc

vim: vimrc FORCE
	git submodule update --init --recursive vim/bundle/Vundle.vim/
	cd vim/bundle/Vundle.vim && git checkout master
	rm -f ~/.vim
	ln -s ${dotfiles}/vim ~/.vim
	vim -c "PluginUpdate"

git: FORCE
	rm -r ~/.gitconfig
	ln -s ${dotfiles}/gitconfig ~/.gitconfig

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
	rm -rf ~/.config/volti
	ln -s ${dotfiles}/volti ~/.config/volti

tint2: FORCE
	rm -rf ~/.config/tint2/tint2rc
	ln -s ${dotfiles}/tint2rc ~/.config/tint2/tint2rc

xscreensaver: FORCE
	rm -f ~/.xscreensaver
	ln -s ${dotfiles}/xscreensaver ~/.xscreensaver

terminator: FORCE
	rm -rf ~/.config/terminator
	ln -s ${dotfiles}/terminator ~/.config/terminator

pms: FORCE
	rm -rf ~/.config/PMS
	ln -s ${dotfiles}/PMS ~/.config/PMS

transmission: FORCE
	rm -rf ~/.config/transmission
	ln -s ${dotfiles}/transmission ~/.config/transmission

FORCE:
