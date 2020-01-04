MAKE := $(MAKE) --no-print-directory
cwd := $(shell pwd)

.PHONY: install
install: stow.pkg user-dirs i3 firefox fish oh-my-fish fisher git tmux tpm nvim plug rust rust-tools node yarn delta fzf alacritty misc

.PHONY: user-dirs
user-dirs: $(HOME)/.config/user-dirs.dirs
$(HOME)/.config/user-dirs.dirs:
	mkdir -p $(HOME)/documents $(HOME)/downloads $(HOME)/dev $(HOME)/libs $(HOME)/music $(HOME)/pictures $(HOME)/videos $(HOME)/.config
	ln -fsn $(cwd)/user-dirs.dirs $(HOME)/.config/user-dirs.dirs

.PHONY: i3
i3: \
	i3.pkg \
	pulseaudio-utils.pkg \
	lm-sensors.pkg \
	fonts-inconsolata.pkg \
	xbacklight.pkg \
	x11-xkb-utils.pkg \
	numlockx.pkg \
	xbanish \
	feh.pkg  \
	libdbus-1-dev.pkg \
	fonts-font-awesome.pkg
	fish --command="which i3status-rs; or cargo install --git https://github.com/greshake/i3status-rust --force"
	stow i3

.PHONY: firefox
firefox: /opt/firefox/firefox
/opt/firefox/firefox:
	@$(MAKE) wget.pkg libdbus-glib-1-2.pkg
	wget -O firefox.tar.gz "https://download.mozilla.org/?product=firefox-devedition-latest-ssl&os=linux64&lang=en-US"
	sudo tar -xf firefox.tar.gz -C /opt
	rm firefox.tar.gz
	sudo mkdir -p /opt/bin
	sudo ln -s /opt/firefox/firefox /opt/bin/firefox

.PHONY: fish
fish:
	@$(MAKE) fish.pkg
	sudo usermod -s /usr/bin/fish joel
	stow fish

.PHONY: oh-my-fish
oh-my-fish: $(HOME)/.config/fish/conf.d/omf.fish
$(HOME)/.config/fish/conf.d/omf.fish:
	@$(MAKE) curl.pkg
	curl -L https://get.oh-my.fish | fish
	fish --command="omf theme default"

.PHONY: fisher
fisher: ~/.config/fish/functions/fisher.fish
~/.config/fish/functions/fisher.fish:
	@$(MAKE) curl.pkg
	curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish
	fisher add tuvistavie/fish-ssh-agent

.PHONY: git
git:
	stow git

.PHONY: tmux
tmux: $(HOME)/.tmux.conf
$(HOME)/.tmux.conf: tmux.pkg
	stow tmux

.PHONY: tpm
tpm: $(HOME)/.tmux/plugins/tpm
$(HOME)/.tmux/plugins/tpm: $(HOME)/.tmux.conf
	git clone https://github.com/tmux-plugins/tpm $(HOME)/.tmux/plugins/tpm
	tmux new -d # ensure tmux server is started
	tmux source $(HOME)/.tmux.conf
	$(HOME)/.tmux/plugins/tpm/bin/install_plugins all

.PHONY: nvim
nvim: $(HOME)/.config/nvim/init.vim
$(HOME)/.config/nvim/init.vim:
	@$(MAKE) neovim.pkg fonts-powerline.pkg
	stow nvim

.PHONY: plug
plug: $(HOME)/.local/share/nvim/site/autoload/plug.vim
$(HOME)/.local/share/nvim/site/autoload/plug.vim: $(HOME)/.config/nvim/init.vim
	@$(MAKE) curl.pkg
	curl -fLo $(HOME)/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

.PHONY: rust
rust: $(HOME)/.cargo
$(HOME)/.cargo:
	@$(MAKE) curl.pkg
	curl https://sh.rustup.rs -sSf | sh -s -- -y

.PHONY: rust-tools
rust-tools: $(HOME)/.cargo/bin/rg $(HOME)/.cargo/bin/fd $(HOME)/.cargo/bin/exa $(HOME)/.cargo/bin/bat
$(HOME)/.cargo/bin/rg: $(HOME)/.cargo
	fish --command="cargo install ripgrep --force"
$(HOME)/.cargo/bin/fd: $(HOME)/.cargo
	fish --command="cargo install fd-find --force"
$(HOME)/.cargo/bin/exa: $(HOME)/.cargo
	@$(MAKE) cmake.pkg
	fish --command="cargo install exa --force"
$(HOME)/.cargo/bin/bat: $(HOME)/.cargo
	fish --command="cargo install bat --force"

.PHONY: node
node: $(HOME)/.volta/bin/volta
$(HOME)/.volta/bin/volta:
	curl https://get.volta.sh | bash
	$(HOME)/.volta/volta install node
	$(HOME)/.volta/volta install yarn
	echo "prefix = $(HOME)/.npm-packages" >> $(HOME)/.npmrc

.PHONY: yarn
yarn: $(HOME)/.npm-packages/bin/yarn
$(HOME)/.npm-packages/bin/yarn:
	npm i -g yarn

.PHONY: delta
delta: $(HOME)/.cargo/bin/delta
$(HOME)/.cargo/bin/delta: $(HOME)/.cargo
	cargo install --git https://github.com/dandavison/delta

.PHONY: fzf
fzf: $(HOME)/.fzf
$(HOME)/.fzf:
	git clone --depth 1 https://github.com/junegunn/fzf.git $(HOME)/.fzf
	$(HOME)/.fzf/install --key-bindings --no-completion --no-update-rc

.PHONY: alacritty
alacritty: $(HOME)/.cargo/bin/alacritty
$(HOME)/.cargo/bin/alacritty: $(HOME)/.cargo
	@$(MAKE) g++.pkg libfreetype6-dev.pkg libfontconfig1-dev.pkg xclip.pkg
	fish --command="cargo install --git https://github.com/jwilm/alacritty --force"
	stow alacritty

.PHONY: starship
starship: $(HOME)/.config/starship.toml
$(HOME)/.config/starship.toml:
	stow starship

.PHONY: %.pkg
%.pkg:
	@[ -z "$(shell dpkg -l | grep '$* ')" ] && sudo apt-get install -y $* || true

i3.pkg: x.pkg
	@which i3 > /dev/null || sudo apt-get install -y i3 suckless-tools

x.pkg:
	@which startx > /dev/null || sudo apt-get install -y xorg x-window-system

.PHONY: xbanish
xbanish: /usr/local/bin/xbanish
/usr/local/bin/xbanish:
	@$(MAKE) gcc.pkg libxext-dev.pkg libxt-dev.pkg libxfixes-dev.pkg libxi-dev.pkg
	[ -d /opt/xbanish ] || sudo git clone https://github.com/jcs/xbanish.git /opt/xbanish
	cd /opt/xbanish && sudo make install

.PHONY: misc
misc:
	@$(MAKE) pulseaudio.pkg pavucontrol.pkg neofetch.pkg unzip.pkg jq.pkg htop.pkg ncdu.pkg tree.pkg evince.pkg scrot.pkg vlc.pkg pm-utils.pkg inxi.pkg thunar.pkg gvfs.pkg
