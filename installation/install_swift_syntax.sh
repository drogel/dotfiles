#!/usr/bin/env bash

# Return if the Swift package is already found in the .vim folder.
localSwiftSyntaxVimDirectory=~/.vim/pack/bundle/start/swift
if [ -d "$localSwiftSyntaxVimDirectory" ]; then
	echo "Swift syntax support for vim seems to be already in place."
	return
fi

# Get the path from which this script was called.
installScriptCallPath=`pwd`

# Create the vim package folder where we will store the swift syntax vim
# folder.
mkdir -p $localSwiftSyntaxVimDirectory &> /dev/null
cd $localSwiftSyntaxVimDirectory

# Set the official Swift repo URL and the folder we are interested in.
swiftSyntaxRepoUrl="https://github.com/apple/swift.git"
swiftSyntaxVimDirectory="/utils/vim"

# Clone the repo and do a sparse checkout only on the folder we are interested
# in.
gitShallowSparseClone() (
  remoteUrl="$1" localDirectory="$2" && shift 2

  mkdir -p "$localDirectory"
  cd "$localDirectory"

  git init
  git remote add -f origin "$remoteUrl"

  git config core.sparseCheckout true

  # Loop over the remaining arguments.
  for i; do
    echo "$i" >> .git/info/sparse-checkout
  done

  git pull --depth=1 origin main
)

echo "Cloning the vim utils from the official Swift repository into $localSwiftSyntaxVimDirectory..."
echo "Hold on, this will take a few minutes."
gitShallowSparseClone $swiftSyntaxRepoUrl "." $swiftSyntaxVimDirectory &> /dev/null

# Move the files in the vim folder to the .vim/pack/bundle/start/swift folder.
mv utils/vim/* .

# Clear the utils folder we cloned, which is now empty.
rm -rf utils/

# Clone an indentation script for Swift that is more configurable and robust
# than the one found in the swift.vim plugin. Put it in the indent/ folder of
# the swift syntax vim directory. For more info see:
# - https://gist.github.com/morefun2compute/bdc6ee6d8b9add60a03b318bd91ba570
# - https://forums.swift.org/t/swift-indentation-for-vim/5011
echo "Installing the Swift for vim indentation logic..."
indentScriptGistId=bdc6ee6d8b9add60a03b318bd91ba570
git clone https://gist.github.com/$indentScriptGistId.git &> /dev/null
mv $indentScriptGistId indent

# Return to where we were
cd $installScriptCallPath
echo "Swift syntax highlighting and indentation logic installed at $localSwiftSyntaxVimDirectory."
echo "Review the /indent/swift.vim script for more information on indenting Swift code on vim."
