# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
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

alias lss="ls -Blah"
alias rm="mv -bt ~/.local/share/Trash/files/"
alias rmm="/bin/rm"
alias count="wc"

alias sshstu="ssh kollerg@condor.cs.wlu.edu"
alias hbar="ssh kollerg@hbar.wlu.edu"

#Condor aliases
alias sshcondor="ssh koller@condor.cs.wlu.edu"
alias ckpt="setarch x86_64 -R -L"
