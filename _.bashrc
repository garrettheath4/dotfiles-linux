# ~/.bashrc: executed by bash(1) for non-login shells.

ifDistIsThenSource () {
	if [ "$#" -ne 2 -o -z "$1" -o -z "$2" ]; then
		echo "ERROR: ifDistIsThenSource needs two non-empty args" 1>&2
		echo "Usage: ifDistIsThenSource: Ubuntu ~/.bashrc.os.ubuntu" 1>&2
		return 1
	fi
	if [ ! -r "$2" ]; then
		echo "ERROR: OS bootstrap script $2 is not readable" 1>&2
		return 2
	fi
	if ( lsb_release -i | fgrep "$1" 1>/dev/null 2>&1 ); then
		source "$2"
	fi
}

# Bootstrap based on OS/Disto
ifDistIsThenSource "Raspbian" ~/.bashrc.os.raspbian

# Source system's global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Source user's local definitions
if [ -f ~/.bashrc.local -a -x ~/.bashrc.local ]; then
	. ~/.bashrc.local
fi

# Enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# User specific aliases and functions
if [ -x "/usr/bin/vim" ]; then
	export EDITOR="/usr/bin/vim"
fi

# User aliases
alias lss="ls -Blah"
alias rmm="/bin/rm"
alias pss="ps aux | fgrep -v fgrep | fgrep"
alias count="wc"

## SSH shortcuts
alias sshstu="ssh kollerg@condor.cs.wlu.edu"
alias sshcondor="ssh koller@condor.cs.wlu.edu"
alias hbar="ssh kollerg@hbar.wlu.edu"

## git shortcuts
alias ggp='git pull && git push'
alias ggb='git branch'
alias ggs='git status'
alias ggd='git diff'
alias gga='git add'
alias ggc='git commit -m'
alias ggl='git log --pretty=oneline --abbrev-commit'

