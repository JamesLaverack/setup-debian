#!/bin/bash
set -euo pipefail

# Install new packages
sudo apt-get install --yes emacs25 git zsh curl tree htop

# Local bin and lib
mkdir -p ~/.bin
mkdir -p ~/.lib

# ZSH
if [ ! -d ~/.oh-my-zsh ] ; then
    curl -Lo /tmp/install.sh https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh
    sh /tmp/install.sh --unattended
    rm /tmp/install.sh
fi

# Emacs Prelude
if [ ! -d ~/.emacs.d/.git ] ; then
    rm -rf ~/.emacs.d
    git clone https://github.com/bbatsov/prelude.git ~/.emacs.d
fi

# Dotfiles
if [ ! -d ~/.dot ] ; then
    git clone https://github.com/svetlyak40wt/dotfiler.git ~/.dot
fi
export PATH=$PATH:~/.dot/bin

if [ ! -d ~/.dot/emacs ] ; then
    dot add https://github.com/JamesLaverack/dot-emacs.git
fi
if [ ! -d ~/.dot/zsh ] ; then
    dot add https://github.com/JamesLaverack/dot-zsh.git
fi
if [ ! -d ~/.dot/git ] ; then
    dot add https://github.com/JamesLaverack/dot-git.git
fi
if [ ! -d ~/.dot/bernkastel ] ; then
    dot add https://github.com/JamesLaverack/dot-bernkastel.git
fi

dot update

# Emacs service mode
systemctl --user enable emacs
systemctl --user start emacs

# Bernkastel ZSH theme
if [ ! -d ~/.lib/bernkastel ] ; then
    git clone https://github.com/JamesLaverack/bernkastel.git ~/.lib/bernkastel
fi

# Fonts
mkdir -p ~/.fonts

# Source Code Pro
wget -nc https://github.com/adobe-fonts/source-code-pro/releases/download/variable-fonts/SourceCodeVariable-Roman.otf --directory-prefix ~/.fonts
wget -nc https://github.com/adobe-fonts/source-code-pro/releases/download/variable-fonts/SourceCodeVariable-Italic.otf --directory-prefix ~/.fonts

# Source Sans Pro
wget -nc https://github.com/adobe-fonts/source-sans-pro/releases/download/variable-fonts/SourceSansVariable-Roman.otf --directory-prefix ~/.fonts
wget -nc https://github.com/adobe-fonts/source-sans-pro/releases/download/variable-fonts/SourceSansVariable-Italic.otf --directory-prefix ~/.fonts

fc-cache

# End comments
echo "Install complete. You probably want to do a few more things:"
echo
echo '1. Change your default shell to ZSH via `chsh -s $(which zsh)`.'
echo '2. Generate an SSH public key via `ssh-keygen -t rsa -b 4096 -C "james@jameslaverack.com"` and upload to GitHub.'

# Launch into ZSH
zsh
