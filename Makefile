dotfiles := $(shell pwd)

install:
	echo "exec openbox-session" > $(HOME)/.xsession
	sudo apt install \
		x-window-system openbox lightdm tint2 conky feh redshift xscreensaver dmenu network-manager-gnome thunar volti pm-utils pavucontrol pulseaudio scrot dirmngr \
		fish tmux tree gksu curl neovim \
		python3-pip openjdk-8-jdk \
		numlockx xclip \
		gparted vlc xarchiver gpicview galculator transmission libreoffice-calc libreoffice-writer mupdf terminator gimp
	sudo usermod -s /usr/bin/fish joel

all: fish fzf tpm plug git conky user-dirs openbox volti tint2 terminator transmission rust-tools yarn rvm go pipenv

.PHONY: oh-my-fish
oh-my-fish: $(HOME)/.config/fish/conf.d/omf.fish
$(HOME)/.config/fish/conf.d/omf.fish:
	curl -L https://get.oh-my.fish | fish

.PHONY: fish
fish: $(HOME)/.config/fish/config.fish
$(HOME)/.config/fish/config.fish: $(HOME)/.config/fish/conf.d/omf.fish
	ln -fsn $(dotfiles)/config.fish $(HOME)/.config/fish/config.fish
	fish --command="omf theme default"

.PHONY: fzf
fzf: $(HOME)/.fzf
$(HOME)/.fzf:
	git clone --depth 1 https://github.com/junegunn/fzf.git $(HOME)/.fzf
	$(HOME)/.fzf/install --key-bindings --no-completion --no-update-rc

.PHONY: tmux
tmux: $(HOME)/.tmux.conf
$(HOME)/.tmux.conf:
	ln -fsn $(dotfiles)/tmux.conf $(HOME)/.tmux.conf

.PHONY: tpm
tpm: $(HOME)/.tmux/plugins/tpm
$(HOME)/.tmux/plugins/tpm: $(HOME)/.tmux.conf
	git clone https://github.com/tmux-plugins/tpm $(HOME)/.tmux/plugins/tpm
	tmux new -d # ensure tmux server is started
	tmux source $(HOME)/.tmux.conf
	$(HOME)/.tmux/plugins/tpm/bin/install_plugins all

.PHONY: tpm-update
tpm-update: tpm
	$(HOME)/.tmux/plugins/tpm/bin/update_plugins all

.PHONY: nvim
nvim: $(HOME)/.config/nvim/init.vim
$(HOME)/.config/nvim/init.vim:
	mkdir -p $(HOME)/.config/nvim
	ln -fsn $(dotfiles)/nvim $(HOME)/.config/nvim/init.vim

.PHONY: plug
plug: $(HOME)/.local/share/nvim/site/autoload/plug.vim
$(HOME)/.local/share/nvim/site/autoload/plug.vim: $(HOME)/.config/nvim/init.vim
	curl -fLo $(HOME)/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

.PHONY: alacritty
alacritty:
	cargo install --git https://github.com/jwilm/alacritty
	ln -fsn $(dotfiles)/alacritty.yml $(HOME)/.config/alacritty/alacritty.yml
	sudo apt install libfreetype6-dev libfontconfig1-dev xclip

.PHONY: git
git: $(HOME)/.gitconfig
$(HOME)/.gitconfig:
	ln -fsn $(dotfiles)/gitconfig $(HOME)/.gitconfig

.PHONY: conky
conky: $(HOME)/.conkyrc
$(HOME)/.conkyrc:
	ln -fsn $(dotfiles)/conkyrc $(HOME)/.conkyrc

.PHONY: user-dirs
user-dirs: $(HOME)/.config/user-dirs.dirs
$(HOME)/.config/user-dirs.dirs:
	mkdir -p $(HOME)/documents $(HOME)/downloads $(HOME)/dev $(HOME)/libs $(HOME)/music $(HOME)/pictures $(HOME)/videos $(HOME)/.config
	ln -fsn $(dotfiles)/user-dirs.dirs $(HOME)/.config/user-dirs.dirs

.PHONY: openbox
openbox: $(HOME)/.config/openbox
$(HOME)/.config/openbox:
	ln -fsn $(dotfiles)/openbox $(HOME)/.config/openbox

.PHONY: volti
volti: $(HOME)/.config/volti/config
$(HOME)/.config/volti/config:
	mkdir -p $(HOME)/.config/volti
	ln -fsn $(dotfiles)/volti $(HOME)/.config/volti/config

.PHONY: tint2
tint2: $(HOME)/.config/tint2/tint2rc
$(HOME)/.config/tint2/tint2rc:
	mkdir -p $(HOME)/.config/tint2
	ln -fsn $(dotfiles)/tint2rc $(HOME)/.config/tint2/tint2rc

.PHONY: terminator
terminator: $(HOME)/.config/terminator
$(HOME)/.config/terminator:
	mkdir -p $(HOME)/.config/terminator
	ln -fsn $(dotfiles)/terminator $(HOME)/.config/terminator/config

.PHONY: transmission
transmission: $(HOME)/.config/transmission/settings.json
$(HOME)/.config/transmission/settings.json:
	mkdir -p $(HOME)/.config/transmission
	ln -fsn $(dotfiles)/transmission.json $(HOME)/.config/transmission/settings.json

.PHONY: rust
rust: $(HOME)/.cargo
$(HOME)/.cargo:
	curl https://sh.rustup.rs -sSf | sh -s -- -y

.PHONY: rust-tools
rust-tools: $(HOME)/.cargo $(HOME)/.cargo/bin/rg $(HOME)/.cargo/bin/fd
$(HOME)/.cargo/bin/rg:
	fish --command="cargo install ripgrep"
$(HOME)/.cargo/bin/fd:
	fish --command="cargo install fd-find"

.PHONY: node
node: /usr/local/bin/node
/usr/local/bin/node:
	git clone https://github.com/tj/n.git $(HOME)/.n
	cd $(HOME)/.n && sudo make install
	sudo n latest
	echo "prefix = $(HOME)/.npm-packages" >> $(HOME)/.npmrc

.PHONY: yarn
yarn: $(HOME)/.npm-packages/bin/yarn
$(HOME)/.npm-packages/bin/yarn: /usr/local/bin/node
	npm i -g yarn

.PHONY: rvm
rvm: $(HOME)/.rvm
$(HOME)/.rvm:
	gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
	curl -sSL https://get.rvm.io | bash -s stable --ruby
	curl -L --create-dirs -o $(HOME)/.config/fish/functions/rvm.fish https://raw.github.com/lunks/fish-nuggets/master/functions/rvm.fish
	fish --command="rvm use default"

.PHONY: go
go: /opt/go
/opt/go:
	cd /opt && sudo curl https://dl.google.com/go/go1.10.2.linux-amd64.tar.gz | sudo tar zxf -

.PHONY: pipenv
pipenv: /usr/local/bin/pipenv
/usr/local/bin/pipenv:
	sudo pip3 install pipenv
