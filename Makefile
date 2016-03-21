dotfiles := $(realpath .)

all: bashrc zshrc tmux vim git conky user-dirs openbox volti tint2 terminator pms transmission

bashrc: FORCE
	ln -fsn ${dotfiles}/bashrc ~/.bashrc

zshrc: FORCE
	ln -fsn ${dotfiles}/zshrc ~/.zshrc

tmux: FORCE
	ln -fsn ${dotfiles}/tmux.conf ~/.tmux.conf
	git submodule update --init --recursive tpm/
	cd tpm && git checkout master
	mkdir -p ~/.tmux/plugins
	ln -fsn ${dotfiles}/tpm ~/.tmux/plugins/tpm
	~/.tmux/plugins/tpm/bin/install_plugins all

vimrc: FORCE
	ln -fsn ${dotfiles}/vimrc ~/.vimrc

vim: vimrc FORCE
	git submodule update --init --recursive vim/bundle/Vundle.vim/
	cd vim/bundle/Vundle.vim && git checkout master && git pull
	ln -fsn ${dotfiles}/vim ~/.vim
	vim +PluginInstall +qall

git: FORCE
	ln -fsn ${dotfiles}/gitconfig ~/.gitconfig

conky: FORCE
	ln -fsn ${dotfiles}/conkyrc ~/.conkyrc

user-dirs: FORCE
	ln -fsn ${dotfiles}/user-dirs.dirs ~/.config/user-dirs.dirs

openbox: FORCE
	ln -fsn ${dotfiles}/openbox ~/.config/openbox

volti: FORCE
	mkdir -p ~/.config/volti
	ln -fsn ${dotfiles}/volti ~/.config/volti/config

tint2: FORCE
	ln -fsn ${dotfiles}/tint2rc ~/.config/tint2/tint2rc

terminator: FORCE
	ln -fsn ${dotfiles}/terminator ~/.config/terminator

pms: FORCE
	ln -fsn ${dotfiles}/PMS ~/.config/PMS

transmission: FORCE
	ln -fsn ${dotfiles}/transmission ~/.config/transmission

FORCE:
