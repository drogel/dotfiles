# Makes vim the deafult EDITOR. This way, you can do Ctrl-x-e in the command
# line to load the command currently being written on vim.
export VISUAL=vim
export EDITOR="$VISUAL"

# Set UTF-8 en US locales for processes that depend on it (like fastlane).
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"

# Custom env var to set the agent to use by default, so that I can easily
# switch in my automations from Claude to Cursor.
export AGENT="${AGENT:-claude --dangerously-skip-permissions}"

# Sets the agent for the current session and updates tmux's environment so that
# new panes spawned via tmux keybindings use the updated value.
set_agent() { export AGENT="$1"; tmux set-environment AGENT "$1"; }

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
