My configuration files, meant for installing on latest debian

    sudo apt install git make
    git clone https://github.com/joelgallant/dotfiles && cd dotfiles

    # for new systems, installs packages
    sudo make install

    # sets up symlinks, installs plugins
    make all
