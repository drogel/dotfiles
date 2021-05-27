# Adds /usr/local/bin/ to the path. This is where homebrew places the binaries
# it installs, so we need to add it to the path to use them from the command
# line.
export PATH=$PATH:/usr/local/bin

# Runs the script needed for fzf to work with autocompletion and fzf key
# bindings.
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
