dotfiles := $(realpath .)

all: bashrc zshrc tmux vim git conky user-dirs openbox volti tint2 terminator pms transmission

bashrc: FORCE
	ln -fs ${dotfiles}/bashrc ~/.bashrc

zshrc: FORCE
	ln -fs ${dotfiles}/zshrc ~/.zshrc

tmux: FORCE
	ln -fs ${dotfiles}/tmux.conf ~/.tmux.conf
	git submodule update --init --recursive tpm/
	cd tpm && git checkout master
	mkdir -p ~/.tmux/plugins
	ln -fs ${dotfiles}/tpm ~/.tmux/plugins/tpm
	~/.tmux/plugins/tpm/bin/install_plugins all

vimrc: FORCE
	ln -fs ${dotfiles}/vimrc ~/.vimrc

vim: vimrc FORCE
	git submodule update --init --recursive vim/bundle/Vundle.vim/
	cd vim/bundle/Vundle.vim && git checkout master && git pull
	ln -fs ${dotfiles}/vim ~/.vim
	vim +PluginInstall +qall

git: FORCE
	ln -fs ${dotfiles}/gitconfig ~/.gitconfig

conky: FORCE
	ln -fs ${dotfiles}/conkyrc ~/.conkyrc

user-dirs: FORCE
	ln -fs ${dotfiles}/user-dirs.dirs ~/.config/user-dirs.dirs

openbox: FORCE
	ln -fs ${dotfiles}/openbox ~/.config/openbox

volti: FORCE
	mkdir -p ~/.config/volti
	ln -fs ${dotfiles}/volti/config ~/.config/volti/config

tint2: FORCE
	ln -fs ${dotfiles}/tint2rc ~/.config/tint2/tint2rc

terminator: FORCE
	ln -fs ${dotfiles}/terminator ~/.config/terminator

pms: FORCE
	ln -fs ${dotfiles}/PMS ~/.config/PMS

transmission: FORCE
	ln -fs ${dotfiles}/transmission ~/.config/transmission

FORCE:
