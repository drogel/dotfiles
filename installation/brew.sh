#!/usr/bin/env bash

# Install command-line tools using Homebrew.

# First, install homebrew if it's not already installed.
if ! which brew > /dev/null; then
	echo "Installing homebrew..."
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

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
brew install vim
brew install grep
brew install openssh
brew install screen
brew install php
brew install gmp

# Install git and git Large File System.
brew install git
brew install git-lfs

# Install jq to manipulate json objects from the command line.
brew install jq

# Install lcov, a tool which provides information about what parts of a program
# are actually covered while running a particular test case.
brew install lcov

# Install fzf and its keybindings for fuzzy completion.
brew install fzf
$(brew --prefix)/opt/fzf/install

# Install ripgrep for recursively searching directories with a regex patterns.
brew install ripgrep
# fzf does not use ripgrep by default, so we need to tell fzf to use ripgrep
# with the FZF_DEFAULT_COMMAND variable. This also modifies fzf so that it
# includes dotfiles in the search results.
if type rg &> /dev/null; then
	export FZF_DEFAULT_COMMAND='rg --files --follow --no-ignore-vcs --hidden'
	export FZF_DEFAULT_OPTS='-m'
fi

# Install swift-format, the official Apple CLI tool for formatting swift code.
brew install swift-format

# Install Nick Lockwood's swiftformat, a CLI tool for formatting swift code.
brew install swiftformat

# Install the Flutter SDK.
brew install --cask flutter

# Install Alacritty, a GPU-accelerated terminal emulator.
brew install --q alacritty --no-quarantine

# Install Amethyst, a window manager for macOS.
brew install --cask amethyst

# Install Flycut, a paste history manager.
brew install --cask flycut

# Install tmux, a terminal multiplexer.
brew install tmux

# Install swiftlint, a Swift tool to enforce coding style and conventions.
brew install swiftlint

# Install yarn, a software packaging system.
brew install yarn

# Install proxyman, an HTTP debugging proxy app.
brew install --cask proxyman

# Install postman, a collaboration platform for API development.
brew install --cask postman

# Install pre-commit, a git hooks manager.
brew install pre-commit

# Install GitHub CLI, a terminal tool to interact with GitHub
brew install gh

# Remove outdated versions from the cellar.
brew cleanup
