#!/usr/bin/env bash
# Script to configure a Linux account with preferred settings
# This script may also install minor programs but everything in this script
# should run to completion without any prompts, sudo or otherwise

# Source directory one-liner (below) from https://stackoverflow.com/a/246128
DOTFILES="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

HIDDENFILES='.bashrc
.bash_profile
.git-completion.bash
.vimrc
.gvimrc
.tmux.conf'

HIDDENDIRS='.vim'

NORMALDIRS='bin
sbin'

for hiddenFile in $HIDDENFILES; do
	if [ -f "_$hiddenFile" ]; then
		if [ ! -e ~/"$hiddenFile" ]; then
			ln -sv "$DOTFILES/_$hiddenFile" ~/"$hiddenFile"
		else
			if [ ! -L ~/"$hiddenFile" ]; then
				echo "Warning: File already exists but is not a link; skipping" ~/"$hiddenFile"
			else
				echo "Info: File already exists and is a link (which is probably good); skipping" ~/"$hiddenFile"
			fi
		fi
	else
		echo "Error: _$hiddenFile does not exist in this dotfiles repository. Please add it to the repository or remove it from the configure.sh file. Skipping."
	fi
done

for hiddenDir in $HIDDENDIRS; do
	if [ -d "_$hiddenDir" ]; then
		if [ ! -e ~/"$hiddenDir" ]; then
			ln -sv "$DOTFILES/_$hiddenDir" ~/"$hiddenDir"
		else
			if [ ! -L ~/"$hiddenDir" ]; then
				echo "Warning: Directory already exists but is not a link; skipping" ~/"$hiddenDir/"
			else
				echo "Info: Directory already exists and is a link (which is probably good); skipping" ~/"$hiddenDir"
			fi
		fi
	else
		echo "Error: _$hiddenDir does not exist in this dotfiles repository. Please add it to the repository or remove it from the configure.sh file. Skipping."
	fi
done

for normalDir in $NORMALDIRS; do
	if [ -d "$normalDir" ]; then
		if [ ! -e ~/"$normalDir" ]; then
			ln -sv "$DOTFILES/$normalDir" ~/"$normalDir"
		else
			if [ ! -L ~/"$normalDir" ]; then
				echo "Warning: Directory already exists but is not a link; skipping" ~/"$normalDir/"
			else
				echo "Info: Directory already exists and is a link (which is probably good); skipping" ~/"$normalDir"
			fi
		fi
	else
		echo "Error: $normalDir does not exist in this dotfiles repository. Please add it to the repository or remove it from the configure.sh file. Skipping."
	fi
done

# Install Vundle Vim package manager
git submodule init && git submodule update
vim +PluginInstall +qall

# Configure Git
git config --global push.default simple
git config --global pull.rebase false
git config --global init.defaultBranch main
git config --global diff.tool vimdiff
git config --global color.ui auto
if [[ $(git config --global user.name) != Garrett* ]]; then
	echo 'Be sure to run the following commands to finish configuring Git:'
	echo '  git config --global user.name "Garrett Heath Koller"'
	echo '  git config --global user.email "garrettheath4@gmail.com"'
fi

