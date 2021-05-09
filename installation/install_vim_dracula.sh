#!/usr/bin/env bash

# Get the path of this script.
INSTALL_SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Create the vim themes folder and move inside it.
mkdir -p ~/.vim/pack/themes/opt &> /dev/null
cd ~/.vim/pack/themes/opt

# Clone the dracula theme project, under the name "dracula".
echo "Installing the dracula vim colorscheme..."
git clone https://github.com/dracula/vim.git dracula

# Add the package and enable the dracula colorscheme in .gvimrc.
echo "\" Apply the dracula colorscheme." >> ~/.gvimrc
echo "packadd! dracula" >> ~/.gvimrc
echo "let g:dracula_colorterm = 0" >> ~/.gvimrc
echo "let g:dracula_italic = 0" >> ~/.gvimrc
echo "colorscheme dracula" >> ~/.gvimrc
echo "" >> ~/.gvimrc

# Return to where we were
cd $INSTALL_SCRIPT_DIR
