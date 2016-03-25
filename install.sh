echo "exec openbox-session" > ~/.xsession
mkdir ~/documents ~/downloads ~/pictures ~/dev ~/libs

sudo apt-get install \
    openbox x-window-system lightdm tint2 conky feh redshift xscreensaver \
    git cmake make gdb vim vim-gtk tmux terminator dmenu tree gksu gparted numlockx \
    network-manager-gnome thunar volti pm-utils pavucontrol pulseaudio scrot \
    python-pip python2.7-dev python3-dev nodejs nodejs-legacy npm \
    chromium vlc xarchiver gpicview galculator transmission libreoffice-calc \
    libjpeg-dev mupdf xclip zsh curl

sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
sudo pip install thefuck matplotlib
sudo npm install plaidchat -g

cd dev && git clone https://github.com/joelg236/dotfiles.git && cd dotfiles && \
git submodule update --init --recursive && make all && cd ~

sudo dpkg --add-architecture i386
sudo apt-get update

echo "Next steps:"
echo "    install firmware-iwlwifi if needed"
echo "    ssh setup https://help.github.com/articles/generating-ssh-keys/"
echo "    choose best apt sources"
