#!/usr/bin/env bash

# Check if xcrun is installed first, since we need it to properly configure sourcekit with vim.
if ! which xcrun > /dev/null; then
	echo "Error: xcrun is missing! I need the xcrun utility from the Xcode Command Line Tools to configure the Swift support for vim!"
	return
fi

# Install swift syntax highlighting for vim.
# Get the path where this script is found. This is where the swift syntax
# highlight installation script should be.
directoryForThisScript="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source $directoryForThisScript/install_swift_syntax.sh

# Download the plug.vim plugin manager and put it in the ~/.vim/autoload
# directory.
if [ ! -s ~/.vim/autoload/plug.vim ]; then
	echo "Plug.vim plugin manager not found. Installing..."
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim &> /dev/null
fi

# Install nodejs if it's not installed already, since it is needed for CoC.
if ! which node > /dev/null; then
	echo "Node not found. It is needed for the CoC vim plugin to work. Installing..."
	curl -sL install-node.now.sh/lts | bash
fi

# Install jq if it's not installed already, since it is needed to edit the CoC
# JSON configuration file.
if ! which jq > /dev/null; then
	echo "jq utility not found. I need it to edit the CoC configuration file. Installing using homebrew..."
	brew install jq
fi

appendLineToFileIfNotPresent() {
	lineToInsert=$1
	file=$2
	grep -qxF "$lineToInsert" $file || echo "$lineToInsert" >> $file
}

insertBeforeLineIfNotPresent() {
	lineToInsert=$1
	lineToMatch=$2
	file=$3
	grep -qxF "$lineToInsert" $file || sed -i '' "/^$lineToMatch/i\\
	$lineToInsert
	" $file
}

# Create the ~/.vimrc file if it's not already there.
vimrc=~/.vimrc
if [ ! -f "$vimrc" ]; then
	echo "Creating the .vimrc file in your home directory..."
	touch $vimrc
fi

# Add the CoC plugin dependency into the .vimrc file if it's not already there.
appendLineToFileIfNotPresent "call plug#begin('~/.vim/plugged')" $vimrc
appendLineToFileIfNotPresent "call plug#end()" $vimrc
insertBeforeLineIfNotPresent "Plug 'neoclide/coc.nvim', {'branch': 'release'}" "call plug#end()" $vimrc

# Install the plugin we just appended to .vimrc.
vim +'PlugInstall --sync' +qall

# Install coc-sourcekit.
vim +CocInstall coc-sourcekit +qall

# Define the path where the CoC settings file is.
cocSettingsFile=~/.vim/coc-settings.json

# Get the iOS SDK paths from xcrun and insert them into the CoC configuration.
insertSourceKitConfig() {
	file=$1
	insertToJson "sourcekit.sdkPath" "$(xcrun --sdk iphonesimulator --show-sdk-path)" $file
	insertToJson "sourcekit.sdk" "$(xcrun --sdk iphonesimulator --show-sdk-version)" $file
	insertToJson "sourcekit.targetArch" "x86_64-apple-ios$(xcrun --sdk iphonesimulator --show-sdk-version)-simulator" $file
}

insertToJson() {
	key=$1
	value=$2
	jsonFile=$3
	jq --arg jsonKey $key --arg jsonValue $value '. += {($jsonKey): $jsonValue}' $jsonFile > $jsonFile.tmp
	mv $jsonFile.tmp $jsonFile
}

# If the CoC settings file is empty, insert an empty JSON object.
if [ ! -s "$cocSettingsFile" ]; then
	printf "{\n}" > $cocSettingsFile
fi

echo "Configuring sourcekit..."
insertSourceKitConfig $cocSettingsFile

echo "Done! You can review the CoC configuration I've installed by inspecting the $cocSettingsFile file, or running vim +CocConfig."
