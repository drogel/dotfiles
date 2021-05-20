# Get the path of the parent of this script. This is where the dotfiles are.
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && cd ../ && pwd )"

# Download the plug.vim plugin manager and put it in the ~/.vim/autoload
# directory.
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install nodejs since it is needed for CoC.
curl -sL install-node.now.sh/lts | bash

# Append the contents of .vimpluginsrc to .vimrc.
cat $DOTFILES_DIR/.vimpluginsrc >> ~/.vimrc

# Install the plugins we just appended to .vimrc.
vim +PlugInstall +qall

# Install coc-sourcekit
vim +CocInstall coc-sourcekit +qall
