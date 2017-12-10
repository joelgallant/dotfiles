dotfiles := $(shell pwd)

all: \
	zsh oh-my-zsh \
	tmux tpm \
	vim vundle \
	git conky user-dirs openbox volti tint2 terminator pms transmission

update: oh-my-zsh-update tpm-update vundle-update
	cd $(dotfiles) && git pull origin master

zsh: oh-my-zsh $(HOME)/.zshrc
$(HOME)/.zshrc:
	ln -fsn $(dotfiles)/zshrc $(HOME)/.zshrc

oh-my-zsh: $(HOME)/.oh-my-zsh
$(HOME)/.oh-my-zsh:
	wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh
	bash install.sh
	rm install.sh ~/.zshrc

oh-my-zsh-update:
	cd $(ZSH) && git pull --rebase origin master

tmux: $(HOME)/.tmux.conf
$(HOME)/.tmux.conf:
	ln -fsn $(dotfiles)/tmux.conf $(HOME)/.tmux.conf

tpm: tmux $(HOME)/.tmux/plugins/tpm
$(HOME)/.tmux/plugins/tpm:
	git clone https://github.com/tmux-plugins/tpm $(HOME)/.tmux/plugins/tpm
	tmux source $(HOME)/.tmux.conf
	$(HOME)/.tmux/plugins/tpm/bin/install_plugins all

tpm-update: tpm
	$(HOME)/.tmux/plugins/tpm/bin/update_plugins all

vim: vundle $(HOME)/.vimrc
$(HOME)/.vimrc:
	ln -fsn $(dotfiles)/vimrc $(HOME)/.vimrc

vundle: $(HOME)/.vimrc $(HOME)/.vim/bundle/Vundle.vim
$(HOME)/.vim/bundle/Vundle.vim:
	mkdir -p $(HOME)/.vim/bundle
	git clone https://github.com/VundleVim/Vundle.vim.git $(HOME)/.vim/bundle/Vundle.vim
	vim +PluginInstall +qall

vundle-update:
	vim +PluginUpdate +qall

nvim: $(HOME)/.config/nvim
$(HOME)/.config/nvim:
	ln -fsn $(dotfiles)/nvim $(HOME)/.config/nvim

plug: nvim $(HOME)/.local/share/nvim/site/autoload/plug.vim
$(HOME)/.local/share/nvim/site/autoload/plug.vim:
	curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

git: $(HOME)/.gitconfig
$(HOME)/.gitconfig:
	ln -fsn $(dotfiles)/gitconfig $(HOME)/.gitconfig

conky: $(HOME)/.conkyrc
$(HOME)/.conkyrc:
	ln -fsn $(dotfiles)/conkyrc $(HOME)/.conkyrc

user-dirs: $(HOME)/.config/user-dirs.dirs
$(HOME)/.config/user-dirs.dirs:
	mkdir -p ~/documents ~/downloads ~/dev ~/libs ~/music ~/pictures ~/videos $(HOME)/.config
	ln -fsn $(dotfiles)/user-dirs.dirs $(HOME)/.config/user-dirs.dirs

openbox: $(HOME)/.config/openbox
$(HOME)/.config/openbox:
	ln -fsn $(dotfiles)/openbox $(HOME)/.config/openbox

volti: $(HOME)/.config/volti/config
$(HOME)/.config/volti/config:
	mkdir -p $(HOME)/.config/volti
	ln -fsn $(dotfiles)/volti $(HOME)/.config/volti/config

tint2: $(HOME)/.config/tint2/tint2rc
$(HOME)/.config/tint2/tint2rc:
	mkdir -p $(HOME)/.config/tint2
	ln -fsn $(dotfiles)/tint2rc $(HOME)/.config/tint2/tint2rc

terminator: $(HOME)/.config/terminator
$(HOME)/.config/terminator:
	mkdir -p $(HOME)/.config/terminator
	ln -fsn $(dotfiles)/terminator $(HOME)/.config/terminator/config

transmission: $(HOME)/.config/transmission/settings.json
$(HOME)/.config/transmission/settings.json:
	mkdir -p $(HOME)/.config/transmission
	ln -fsn $(dotfiles)/transmission.json $(HOME)/.config/transmission/settings.json

clean:
	rm -rf $(HOME)/.zshrc $(HOME)/.oh-my-zsh $(ZSH) $(HOME)/.tmux.conf \
		$(HOME)/.tmux/plugins $(HOME)/.vimrc $(HOME)/.vim/bundle \
		$(HOME)/.gitconfig $(HOME)/.conkyrc $(HOME)/.config/user-dirs.dirs \
		$(HOME)/.config/openbox $(HOME)/.config/volti $(HOME)/.config/tint2 \
		$(HOME)/.config/terminator $(HOME)/.config/transmission

install:
	echo "exec openbox-session" > ~/.xsession
	sudo apt-get install \
		openbox x-window-system lightdm tint2 conky feh redshift xscreensaver \
		cmake gdb vim vim-gtk neovim tmux terminator dmenu tree gksu gparted numlockx \
		network-manager-gnome thunar volti pm-utils pavucontrol pulseaudio scrot \
		zsh python-pip python2.7-dev python3-dev nodejs nodejs-legacy npm \
		chromium vlc xarchiver gpicview galculator transmission \
		libreoffice-calc libreoffice-writer mupdf xclip curl
	gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
	curl -sSL https://get.rvm.io | bash -s stable --ruby --rails
	curl https://sh.rustup.rs -sSf | sh -s -- -y
	sudo npm install plaidchat -g
	sudo npm install diff-so-fancy -g
	echo "export rvmsudo_secure_path=1" >> ~/.bashrc
	rvmsudo gem install tmuxinator

.PHONY: \
	zsh oh-my-zsh oh-my-zsh-update \
	tmux tpm tpm-update \
	vim vundle vundle-update \
	git conky user-dirs openbox volti tint2 terminator pms transmission \
	clean install
