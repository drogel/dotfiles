# Source the shell dotfiles.
# * .private is used for configurations I don't want to share.
for file in $DOTFILES_SOURCE/.{bash_config,bash_prompt,osx,aliases,private}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;
