dotfiles := $(shell pwd)

install:
	echo "exec openbox-session" > $(HOME)/.xsession
	sudo apt install \
		x-window-system openbox lightdm tint2 conky feh redshift xscreensaver dmenu network-manager-gnome thunar volti pm-utils pavucontrol pulseaudio scrot \
		fish tmux tree gksu curl \
		numlockx xclip \
		neovim \
		gparted vlc xarchiver gpicview galculator transmission libreoffice-calc libreoffice-writer mupdf terminator gimp \
	sudo usermod -s /usr/bin/fish joel

all: fish fzf tpm plug git conky user-dirs openbox volti tint2 terminator transmission

.PHONY: fisher
fisher: $(HOME)/.config/fish/functions/fisher.fish
$(HOME)/.config/fish/functions/fisher.fish:
	curl -Lo $(HOME)/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher

.PHONY: fish
fish: $(HOME)/.config/fish/config.fish
$(HOME)/.config/fish/config.fish: $(HOME)/.config/fish/functions/fisher.fish
	ln -fsn $(dotfiles)/config.fish $(HOME)/.config/fish/config.fish
	fish --command="fisher rafaelrinaldi/pure"

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
tpm: tmux $(HOME)/.tmux/plugins/tpm
$(HOME)/.tmux/plugins/tpm:
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
plug: nvim $(HOME)/.local/share/nvim/site/autoload/plug.vim
$(HOME)/.local/share/nvim/site/autoload/plug.vim:
	curl -fLo $(HOME)/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

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
	mkdir -p ~/documents ~/downloads ~/dev ~/libs ~/music ~/pictures ~/videos $(HOME)/.config
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
