#!/usr/bin/env bash

# Check if the user is sure about the consequences of using this script.
read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1 shouldInit;
echo "";
if [[ ! $shouldInit =~ ^[Yy]$ ]]; then
	echo "Okay, then. Nothing has been overwritten. Exiting...";
	return;
fi;

# Get the path from which this script was called.
callPath=`pwd`

# Get the path of the parent of this script. This is where the dotfiles are.
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && cd ../ && pwd )"

# Go to the directory of the dotfiles.
cd $DOTFILES_DIR

# Check for updates.
read -p "Do you want me to see if there's an updated version of the dotfiles? (y/n) " -n 1 shouldUpdate;
echo "";
if [[ $shouldUpdate =~ ^[Yy]$ ]]; then
	echo "Sure! Updating the dotfiles...";
	git pull origin master;
else
	echo "I guess I'll continue without updating.";
fi;

# First, copy the config files to the ~/ folder and run dos2unix on them to
# clear non-unix artifacts that they might have.
for file in $DOTFILES_DIR/.{gitconfig,gitignore,vimrc,xvimrc,gvimrc,ideavimrc,vim,inputrc,bash_profile}; do
	if [ -r "$file" ] && [ -f "$file" ]; then
			echo "Copying $file into the home directory...";
			dos2unix "$file" &> /dev/null;
			cp "$file" ~/;
	fi
done;

# Install the dracula vim theme.
source installation/install_vim_dracula.sh

# Install the Swift syntax highlight for Vim.
# If we don't find the files for the Swift syntax highlight for Vim, we ask the
# user for permission, since this operation takes a few minutes.
if [ ! -d ~/.vim/pack/bundle/start/swift/ ]; then
	echo "It looks like you don't have the Swift syntax highlight for Vim configured."
	read -p "Do you want me to install it? It'll take a few minutes. (y/n) " -n 1 shouldInstallSwiftSyntax;
	echo "";
	if [[ $shouldInstallSwiftSyntax =~ ^[Yy]$ ]]; then
		source installation/install_swift_syntax.sh;
	else
		echo "Okay, continuing without installing the Swift syntax for Vim...";
	fi;
fi;

# Append the contents of the .vimrc file to the .xvimrc and .ideavimrc file so
# that the vim configuration is shared across vim, xvim and IntelliJ IDEA. 
# Do the same for the other vim-related configuration files, or else they won't
# work on xcode with xvim.
appendContentsIfAvailable() {
	FROM_FILE=$1
	TO_FILE=$2
	if [ -r $FROM_FILE ] && [ -f $FROM_FILE ]; then
		cat $FROM_FILE >> $TO_FILE;
	fi
}

appendContentsIfAvailable ~/.gvimrc ~/.vimrc
appendContentsIfAvailable ~/.vimrc ~/.xvimrc
appendContentsIfAvailable ~/.vimrc ~/.ideavimrc 

# Append the contents of the .pluginvimrc file to the .vimrc files, since I
# like to keep the vim plugins configuration in a separate file.
echo "Installing vim plugins..."
appendContentsIfAvailable .pluginvimrc ~/.vimrc
vim +'PlugInstall --sync' +qall &> /dev/null

# Prepend the path of this script to the .bash_profile so it knows the source
# for the dotfiles.
echo -e "\n$(cat ~/.bash_profile)" > ~/.bash_profile
echo -e "export DOTFILES_SOURCE=\"$DOTFILES_DIR\";\n$(cat ~/.bash_profile)" > ~/.bash_profile
echo -e "# Export the path of the dotfiles to an env variable for easy access.\n$(cat ~/.bash_profile)" > ~/.bash_profile

echo "Applying configuration changes...";
source ~/.bash_profile;

# Return to where we were
cd $callPath

echo "Done! I hope you enjoy this configuration, have a great day!";
