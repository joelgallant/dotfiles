# My Dotfiles
I use [debian testing](https://cdimage.debian.org/cdimage/daily-builds/daily/arch-latest/amd64/iso-cd/debian-testing-amd64-netinst.iso).

Use TUI installer, chose normal options. Partitioning is of course, up to the needs of the computer.

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
