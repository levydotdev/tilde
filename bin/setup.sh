#!/usr/bin/env sh
set -e

echo "[i] Ask for admin permissions"
sudo -v

# Move to home folder
cd

# Create local tilde directory
mkdir -p ~/Workspace/playpen/tilde

# Install Command Line Tools
if [[ ! -x /usr/bin/gcc ]]; then
  echo "[i] Install macOS Command Line Tools"
  xcode-select --install
fi

# Install homebrew
if [[ ! -x /usr/local/bin/brew ]]; then
  echo "[i] Install Homebrew"
  # get this from https://brew.sh/
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Clone tilde dotfiles
if [[ ! -d ~/Workspace/playpen/tilde/ ]]; then
    echo "[i] Cloning dotfiles directory"
    git clone https://github.com/levydotdev/tilde.git ~/Workspace/playpen/tilde
fi

# Move to dotfiles directory
cd ~/Workspace/playpen/tilde
$SHELL

echo "[i] Get latest versions of dotfiles"
git pull origin main

echo "[i] Done."
exit 0