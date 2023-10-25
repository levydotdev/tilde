#!/usr/bin/env bash
set -euo pipefail

IFS=$'\n'

echo "${tty_blue}[i]${tty_reset} Ask for admin permissions"
sudo -v

# Move to home folder
cd

# Create local tilde directory
mkdir -p ~/Workspace/playpen/tilde && cd $_

# Install Command Line Tools
if [[ ! -x /Library/Developer/CommandLineTools/usr/bin/git ]]; then
  echo "${tty_blue}[i]${tty_reset} Install macOS Command Line Tools"
  xcode-select --install &> /dev/null

  until $(xcode-select --print-path &> /dev/null); do
    sleep 5;
  done
fi

# Install homebrew
if [[ ! -x /usr/local/bin/brew ]]; then
  echo "${tty_blue}[i]${tty_reset} Install Homebrew"
  # instructions: https://brew.sh/
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Clone tilde dotfiles
if [[ ! -d ~/Workspace/playpen/tilde/.git ]]; then
    echo "${tty_blue}[i]${tty_reset} Cloning dotfiles directory"
    git clone https://github.com/levydotdev/tilde.git ~/Workspace/playpen/tilde
fi

echo "${tty_blue}[i]${tty_reset} Get latest versions of dotfiles"
git pull origin main

echo "${tty_blue}[i]${tty_reset} Done."
exit 0