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

generalFiles=("bash_config" "bash_prompt" "aliases" "private")

sourceFiles "${generalFiles[@]}"

if [ "$(uname)" == "Darwin" ]; then
	macosFiles=("osx")
	sourceFiles "${macosFiles[@]}"
fi
