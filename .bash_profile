# Makes vim the deafult EDITOR. This way, you can do Ctrl-x-e in the command
# line to load the command currently being written on vim.
export VISUAL=vim
export EDITOR="$VISUAL"

# Source the shell dotfiles.
# * .private is used for configurations I don't want to share.
sourceFiles() {
	fileNames=("$@")
	for fileName in "${fileNames[@]}"; do
		file=$DOTFILES_SOURCE/."$fileName"
		[ -r "$file" ] && [ -f "$file" ] && source "$file";
	done;
	unset file;
}

generalFiles=("bash_config" "bash_prompt" "bashrc" "aliases" "private")

sourceFiles "${generalFiles[@]}"

# Only source the .osx dotfile if we are running on a macOS machine.
if [ "$(uname)" == "Darwin" ]; then
	macosFiles=("osx")
	sourceFiles "${macosFiles[@]}"
fi

# Adds Cursor binary locations to the path
export PATH="$HOME/.local/bin:$PATH"

# Sets up rbenv
echo 'eval "$(rbenv init - bash)"' >> ~/.bash_profile
