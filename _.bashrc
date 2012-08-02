# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions
export EDITOR="/usr/bin/vim"

alias lss="ls -Blah"
alias rm="mv -bt ~/.local/share/Trash/files/"
alias rmm="/bin/rm"
alias count="wc"

alias sshstu="ssh kollerg@condor.cs.wlu.edu"
alias hbar="ssh kollerg@hbar.wlu.edu"

#Condor aliases
alias sshcondor="ssh koller@condor.cs.wlu.edu"
alias ckpt="setarch x86_64 -R -L"
