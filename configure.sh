#!/usr/bin/env bash
# Script to configure a Linux account with preferred settings
# This script may also install minor programs but everything in this script
# should run to completion without any prompts, sudo or otherwise

# Source directory one-liner (below) from https://stackoverflow.com/a/246128
DOTFILES="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

HIDDENFILES='.bashrc
.git-completion.bash
.vimrc
.gvimrc
.tmux.conf'

HIDDENDIRS='.vim'

NORMALDIRS='bin
sbin'

for hf in $HIDDENFILES; do
	if [ -f "_$hf" ]; then
		if [ ! -e ~/"$hf" ]; then
			ln -sv "$DOTFILES/_$hf" ~/"$hf"
		else
			echo "Warning:" ~/"$hf already exists; leaving it"
		fi
	else
		echo "Warning: _$hf does not exist"
	fi
done

for hd in $HIDDENDIRS; do
	if [ -d "_$hd" ]; then
		if [ ! -e ~/"$hd" ]; then
			ln -sv "$DOTFILES/_$hd" ~/"$hd"
		else
			echo "Warning:" ~/"$hd/ already exists; leaving it"
		fi
	else
		echo "Warning: _$hd does not exist"
	fi
done

for nd in $NORMALDIRS; do
	if [ -d "$nd" ]; then
		if [ ! -e ~/"$nd" ]; then
			ln -sv "$DOTFILES/$nd" ~/"$nd"
		else
			echo "Warning:" ~/"$nd/ already exists; leaving it"
		fi
	else
		echo "Warning: $nd does not exist"
	fi
done

