# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions
alias lss="ls -Blah"
alias rm="mv -bt ~/.local/share/Trash/files/"
alias rmm="/bin/rm"
