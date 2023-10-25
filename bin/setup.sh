#!/usr/bin/env bash
set -e

echo "[i] Ask for admin permissions"
sudo -v

# Move to home folder
cd

# Create local tilde directory
mkdir -p ~/Workspace/playpen/tilde

# Install Command Line Tools
if [[ ! -x /Library/Developer/CommandLineTools/usr/bin/git ]]; then
  echo "[i] Install macOS Command Line Tools"
  xcode-select --install &> /dev/null

  until $(xcode-select --print-path &> /dev/null); do
    sleep 5;
  done
fi

# Install homebrew
if [[ ! -x /usr/local/bin/brew ]]; then
  echo "[i] Install Homebrew"
  # instructions: https://brew.sh/
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Clone tilde dotfiles
if [[ ! -d ~/Workspace/playpen/tilde/ ]]; then
    echo "[i] Cloning dotfiles directory"
    git clone https://github.com/levydotdev/tilde.git ~/Workspace/playpen/tilde
fi

echo "[i] Get latest versions of dotfiles"
cd ~/Workspace/playpen/tilde && git pull origin main

echo "[i] Done."
exit 0