#!/usr/bin/env bash

# Get the path of this script.
INSTALL_SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Create the vim package folder where we will store the swift syntax vim
# folder.
mkdir -p ~/.vim/pack/bundle/start/swift &> /dev/null
cd ~/.vim/pack/bundle/start/swift

# Set the official Swift repo URL and the folder we are interested in.
swiftSyntaxRepoUrl="https://github.com/apple/swift.git"
swiftSyntaxVimDirectory="/utils/vim"

# Clone the repo and do a sparse checkout only on the folder we are insterested
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

echo "Cloning the vim utils from the official Swift repository..."
echo "Hold on, this will take a few minutes."
gitShallowSparseClone $swiftSyntaxRepoUrl "." $swiftSyntaxVimDirectory &> /dev/null

# Move the files in the vim folder to the .vim/pack/bundle/start/swift folder.
mv utils/vim/* .

# Clear the utils folder we cloned, which is now empty.
rm -rf utils/

# Return to where we were
cd $INSTALL_SCRIPT_DIR
