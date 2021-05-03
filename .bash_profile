# Add `~/bin` to the `$PATH`
export PATH="$HOME/bin:$PATH";

# Load the shell dotfiles. Move this .bash_profile file to the ~/
# folder, and keep the rest of the dotfiles inside the ~/dotfiles
# folder.
# * ~/.path can be used to extend `$PATH`.
# * ~/.private is used for configurations I don't want to share.
for file in ~/dotfiles/.{bash_prompt,osx,aliases,private}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# Copy the vim and xvim config files to the ~/ folder
for file in ~/dotfiles/.{vimrc,xvimrc}; do
	[ -r "$file" ] && [ -f "$file" ] && cp "$file" ~/;
done;

eval $(thefuck --alias)
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
