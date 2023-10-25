#!/usr/bin/env bash
set -euo pipefail

IFS=$'\n'

info() {
  printf "\033[1;34m[i]\033[0m %s\n" "$@"
}

info "Ask for admin permissions"
sudo -v

# Move to home folder
cd

# Create local tilde directory
mkdir -p ~/Workspace/playpen/tilde && cd $_

# Install Command Line Tools
if [[ ! -x /Library/Developer/CommandLineTools/usr/bin/git ]]; then
  info "Install macOS Command Line Tools"
  xcode-select --install &> /dev/null

  until $(xcode-select --print-path &> /dev/null); do
    sleep 5;
  done
fi

# Install homebrew
if [[ ! -x /usr/local/bin/brew ]]; then
  info "Install Homebrew"
  # instructions: https://brew.sh/
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Clone tilde dotfiles
if [[ ! -d ~/Workspace/playpen/tilde/.git ]]; then
    info "Cloning dotfiles directory"
    git clone https://github.com/levydotdev/tilde.git ~/Workspace/playpen/tilde
fi

info "Get latest versions of dotfiles"
git pull origin trunk

info "Done."
exit 0