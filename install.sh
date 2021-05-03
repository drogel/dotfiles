#!/usr/bin/env bash

# Check if the user is sure about the consequences of using this script.
read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1 shouldInit;
echo "";
if [[ ! $shouldInit =~ ^[Yy]$ ]]; then
	echo "Okay, then. Nothing has been overwritten. Exiting...";
	return;
fi;

# Get the path from which this script was called.
INSTALL_SCRIPT_CALL_PATH=`pwd`

# Get the path of this script.
INSTALL_SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Go to the directory of this script.
cd $INSTALL_SCRIPT_DIR

# Check for updates.
read -p "Do you want me to see if there's an updated version of the dotfiles? (y/n) " -n 1 shouldUpdate;
echo "";
if [[ $shouldUpdate =~ ^[Yy]$ ]]; then
	echo "Sure! Updating the dotfiles...";
	git pull origin master;
else
	echo "I guess I'll continue without updating.";
fi;

# First, copy the config files to the ~/ folder.
for file in $INSTALL_SCRIPT_DIR/.{gitconfig,vimrc,xvimrc,gvimrc,ideavimrc,vim,bash_profile}; do
	if [ -r "$file" ] && [ -f "$file" ]; then
			echo "Copying $file into the home directory...";
			cp "$file" ~/;
	fi
done;

# Append the contents of the .vimrc file to the .xvimrc and .ideavimrc file so
# that the vim configuration is shared across vim, xvim and IntelliJ IDEA. 
# Do the same for the other vim-related configuration files, or else they won't
# work on xcode with xvim.
appendContentsIfAvailable() {
	FROM_FILE=$1
	TO_FILE=$2
	if [ -r $FROM_FILE ] && [ -f $FROM_FILE ]; then
		echo "Completing $TO_FILE configuration...";
		cat ~/$FROM_FILE >> ~/$TO_FILE;
	fi
}

appendContentsIfAvailable .gvimrc .vimrc
appendContentsIfAvailable .vimrc .xvimrc
appendContentsIfAvailable .vimrc .ideavimrc 

# Prepend the path of this script to the .bash_profile so it knows the source
# for the dotfiles.
echo -e "\n$(cat ~/.bash_profile)" > ~/.bash_profile
echo -e "export DOTFILES_SOURCE=\"$INSTALL_SCRIPT_DIR\";\n$(cat ~/.bash_profile)" > ~/.bash_profile
echo -e "# Export the path of the dotfiles to an env variable for easy access.\n$(cat ~/.bash_profile)" > ~/.bash_profile

echo "Applying configuration changes...";
source ~/.bash_profile;

# Return to where we were
cd $INSTALL_SCRIPT_CALL_PATH

echo "Done! I hope you enjoy this configuration, have a great day!";
