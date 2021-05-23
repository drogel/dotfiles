#!/usr/bin/env bash

# Install command-line tools using Homebrew.

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Save Homebrew’s installed location.
BREW_PREFIX=$(brew --prefix)

# Install a modern version of Bash.
brew install bash
brew install bash-completion2

# Switch to using brew-installed bash as default shell.
if ! fgrep -q "${BREW_PREFIX}/bin/bash" /etc/shells; then
  echo "${BREW_PREFIX}/bin/bash" | sudo tee -a /etc/shells;
  chsh -s "${BREW_PREFIX}/bin/bash";
fi;

# Install more recent versions of some macOS tools.
brew install vim --with-override-system-vi
brew install grep
brew install openssh
brew install screen
brew install php
brew install gmp

# Install thefuck, which corrects your previous console command.
brew install thefuck

# Install git and git Large File System.
brew install git
brew install git-lfs

# Install jq to manipulate json objects from the command line.
brew install jq

# Install fzf and its keybindings for fuzzy completion.
brew install fzf
$(brew --prefix)/opt/fzf/install

# Install ripgrep for recursively searching directories with a regex patterns.
brew install ripgrep
# fzf does not use ripgrep by default, so we need to tell fzf to use ripgrep
# with the FZF_DEFAULT_COMMAND variable.
if type rg &> /dev/null; then
  export FZF_DEFAULT_COMMAND='rg --files'
  export FZF_DEFAULT_OPTS='-m'
fi

# Remove outdated versions from the cellar.
brew cleanup
