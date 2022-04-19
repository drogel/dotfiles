# Adds /usr/local/bin/ to the path. This is where homebrew places the binaries
# it installs, so we need to add it to the path to use them from the command
# line.
export PATH=$PATH:/usr/local/bin

# Runs the script needed for fzf to work with autocompletion and fzf key
# bindings.
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Adds homebrew to the path for M1 macs.
eval $(/opt/homebrew/bin/brew shellenv)

# Shell will launch tmux on start up. It will only do so if tmux exists on the
# system, if we are on an interactive shell, and if tmux is not trying to run
# within itself.
if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  exec tmux
fi
