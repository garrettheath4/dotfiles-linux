#!/bin/bash
# Script to configure a Mac account with preferred settings
# This script may also install minor programs but everything in this script
# should run to completion without any prompts, sudo or otherwise

EXPORTS="`pwd`"

HIDDENFILES='.bashrc
.vimrc
.gvimrc'

HIDDENDIRS='.vim'

NORMALDIRS='bin
sbin'

ConfirmOverwrite () {
	# Usage: ConfirmOverwrite FileThatExists
	# Returns: 0 for YES
	# (as $?): 1 for NO
	read -p "Warning: $1 already exists. Replace? (y/n) [n]: " confirmreplace
	if [ "$confirmreplace" != "y" ]; then
		# Return NO
		echo 1
		return 1
	else
		# Return YES
		echo 0
		return 0
	fi
}

for hf in $HIDDENFILES; do
	if [ -f "_$hf" ]; then
		if [[ ! -e ~/"$hf" || "`ConfirmOverwrite ~/$hf`" == "0" ]]; then
			rm -rf ~/"$hf"
			ln -sfv "$EXPORTS/_$hf" ~/"$hf"
		fi
	else
		echo "Warning: _$hf does not exist"
	fi
done

for hd in $HIDDENDIRS; do
	if [ -d "_$hd" ]; then
		if [[ ! -e ~/"$hd" || "`ConfirmOverwrite ~/$hd/`" == "0" ]]; then
			rm -rf ~/"$hd"
			ln -sfv "$EXPORTS/_$hd" ~/"$hd"
		fi
	else
		echo "Warning: _$hd does not exist"
	fi
done

for nd in $NORMALDIRS; do
	if [ -d "$nd" ]; then
		if [[ ! -e ~/"$nd" || "`ConfirmOverwrite ~/$nd/`" == "0" ]]; then
			rm -rf ~/"$nd"
			ln -sfv "$EXPORTS/$nd" ~/"$nd"
		fi
	else
		echo "Warning: $nd does not exist"
	fi
done
