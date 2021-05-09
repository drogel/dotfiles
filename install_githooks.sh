#!/usr/bin/env bash

# Check if the user is running this script from the root of a git-tracked
# project.
if [ ! -d .git/ ]; then
	echo "No .git folder found. This script must be run from the root of a git-tracked project!";
	return;
fi;

installGitHooksTracking() {
	echo "Installing the hooks in .githooks...";
	
	# Copy the .githooks folder to the project.
	cp -R $INSTALL_SCRIPT_DIR/.githooks .;
	
	# Change the local git configuration for this project so that the hooks
	# defined in the .githooks folder are used.
	git config core.hooksPath .githooks;
}

# Get the path of this script.
INSTALL_SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Check if the user wants to track the hooks we are about to add. If the user
# does not want to track them, the installation will be done only on the .git
# folder of the project.
echo "We are about to install some git hooks to your project. Do you want to track the hooks?";
echo "If you say yes, then the hooks will be installed in a folder called .githooks in this project.";
echo "If you say no, then the hooks will be installed in the .git folder of this project. By default, this folder is not tracked by git.";
read -p "Do you want the hooks to be tracked by git? (y/n) " -n 1 shouldTrack;
echo "";
if [[ $shouldTrack =~ ^[Yy]$ ]]; then
	installGitHooksTracking;
fi;

echo "Done! The git hooks should be available now.";
