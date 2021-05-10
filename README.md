<h2 align="center">My dotfiles</h2>
<p align="center">
  <img src="https://i.imgur.com/bIYCrP4.png">
</p>

## Installation

> **Warning:** you probably don't want to install these dotfiles as they are. Installing them using the installation scripts will override your current shell configuration, and they will add behavior that might be strange to you. You will be better off just looking at the configuration files and stealing the bits that you find interesting or useful (everything is [in the public domain](./LICENSE.md), you can do whatever you want with this files).

You can clone the repository wherever you want. For example, I put my dotfiles in `~/dotfiles/`. The installation script will pull in the latest version and copy the dotfiles to your home folder.

To clone and install the dotfiles direclty, run:

```bash
git clone https://github.com/drogel/dotfiles.git && source dotfiles/installation/install.sh
```

To update the dotfiles, simply run:

```bash
source $DOTFILES_SOURCE/installation/install.sh
```

### What's the `.githooks` folder?

The `.githooks` folder contains custom client-side scripts that I use in my personal Git repositories. These are not part of the global configuration and they will not be installed with the installation script. They should be installed specifically in the Git repository that wants to use them.

To install the hooks, `cd` into your local Git repository of your project and run:

```bash
source $DOTFILES_SOURCE/installation/install_githooks.sh
```

### What's the `.private` file?

If `~/.private` exists, it will be sourced along with the other files. You can use this to add custom commands without forking this repository, or to add commands you don’t want to commit to a public repository.

For instance, I set my Git credentials in my `~/.private` file, like this:

```bash
# My Git credentials.
# Not in the repository, to prevent people from accidentally committing under my name.
GIT_AUTHOR_NAME="Diego Rogel"
GIT_AUTHOR_EMAIL="diegorogel3d@hotmail.com"
GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"
GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"
git config --global user.name "$GIT_AUTHOR_NAME"
git config --global user.email "$GIT_AUTHOR_EMAIL"
```

## Feedback

Suggestions, bug reports and improvements [are very welcome!](https://github.com/drogel/dotfiles/issues)!

## Author

- **Diego Rogel** - [GitHub](https://github.com/drogel).
