# My Dotfiles
I use [debian testing](https://www.debian.org/devel/debian-installer/).

Use TUI installer, chose normal options. Partitioning is of course, up to the computer.
I use ext4 still, and normally use encryption.

De-select any desktop environment, and include "SSH Server" for remoting in.

After rebooting, install should be as simple as a curl -> sh.

```bash
sudo apt-get update && sudo apt-get install -y curl

curl https://raw.githubusercontent.com/joelgallant/dotfiles/main/setup.sh?$(date +%s) -sSf | bash
```

### Main Programs
**Window Manager**: [i3](https://i3wm.org)
**Terminal**: [st](https://st.suckless.org)
**Multiplexer**: [tmux](https://github.com/tmux/tmux)
**Shell**: [zsh](http://zsh.sourceforge.net)
**Editor**: [neovim](https://neovim.io)
**Browser**: [firefox](https://firefox.com)

- Programs installed
  - xrandr, quickrandr
  - dlna, media access
  - programming toolchains
  - lldb, gdb, rr
  - docker, kube
  - virt-manager
  - vs code
  - gpg
  - ssh keys, agent
  - dropbox
  - wine
  - spotify
  - microcode updates
  - starship
  - pgadmin
  - pia
  - chrome
  - azure data studio
  - rust tools, targets, cargo plugins

    locking and sleep
    grub
    plymouth

- Configurations
  - i3
  - zsh
  - tmux
  - vim
  - git
  - ssh
  - starship
