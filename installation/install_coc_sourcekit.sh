#!/usr/bin/env bash

# Download the plug.vim plugin manager and put it in the ~/.vim/autoload
# directory.
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install nodejs since it is needed for CoC.
curl -sL install-node.now.sh/lts | bash

# Add the CoC plugin dependency into the .vimrc file if it's not already there.
insertLineIntoFileIfNotPresent() {
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

vimrc=~/.vimrc

# Create the ~/.vimrc file if it's not already there.
if [ ! -f "$vimrc" ]; then
	touch $vimrc
fi
insertLineIntoFileIfNotPresent "call plug#begin('~/.vim/plugged')" $vimrc
insertLineIntoFileIfNotPresent "call plug#end()" $vimrc
insertBeforeLineIfNotPresent "Plug 'neoclide/coc.nvim', {'branch': 'release'}" "call plug#end()" $vimrc

# Install the plugin we just appended to .vimrc.
vim +PlugInstall +qall

# Install coc-sourcekit
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

if [ ! -s "$cocSettingsFile" ]; then
	printf "{\n}" > $cocSettingsFile
fi

insertSourceKitConfig $cocSettingsFile
