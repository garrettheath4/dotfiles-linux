# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Source local definitions
if [ -f ~/.bashrc.local -a -x ~/.bashrc.local ]; then
	. ~/.bashrc.local
fi

# Enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# User specific aliases and functions
export EDITOR="/usr/bin/vim"

if [ -d ~/.local/share/Trash/files ]; then
	alias rm="mv -bt ~/.local/share/Trash/files/"
else
	echo ~/.local/share/Trash/files" does not exist"
	echo "Please move something to the trash to activate the rm alias"
fi

alias lss="ls -Blah"
alias rmm="/bin/rm"
alias pss="ps aux | fgrep -v fgrep | fgrep"
alias count="wc"

alias sshstu="ssh kollerg@condor.cs.wlu.edu"
alias sshcondor="ssh koller@condor.cs.wlu.edu"
alias hbar="ssh kollerg@hbar.wlu.edu"
