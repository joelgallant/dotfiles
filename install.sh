echo "exec openbox-session" > ~/.xsession
mkdir ~/documents ~/downloads ~/pictures ~/dev ~/libs

sudo apt-get install \
    openbox x-window-system lightdm tint2 conky feh redshift xscreensaver \
    git cmake make vim vim-gtk terminator dmenu gksu gparted numlockx \
    network-manager-gnome thunar volti pm-utils pavucontrol scrot \
    python-pip python2.7-dev python3-dev nodejs nodejs-legacy npm \
    chromium vlc xarchiver gpicview galculator transmission libreoffice-calc \
    libjpeg-dev mupdf

sudo pip install thefuck matplotlib
sudo npm install plaidchat -g

cd dev && git clone https://github.com/joelg236/dotfiles.git && cd dotfiles && \
git submodule update --init --recursive && make all && cd ~

cd libs && git clone https://github.com/Itseez/opencv.git && cd opencv && \
mkdir build && cd build && cmake .. && sudo make install

sudo dpkg --add-architecture i386
sudo apt-get update

echo "Next steps:"
echo "    install firmware-iwlwifi if needed"
echo "    github ssh setup https://help.github.com/articles/generating-ssh-keys/"
echo "    adjust multimonitor support in openbox/autostart"
echo "    choose best apt sources"
