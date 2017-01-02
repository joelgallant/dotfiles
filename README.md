# dotfiles
My configuration files for various applications

    # prep for a new install
    su
    apt-get install sudo
    adduser joel sudo
    exit
    sudo apt-get install git make
    git clone https://github.com/joelgallant/dotfiles.git
    cd dotfiles

    sudo make install # for new systems, installs packages
    make all # sets up syslinks for configuration files
    make update # updates system

See makefile for more targets
