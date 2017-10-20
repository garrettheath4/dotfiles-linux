# ~/.bashrc: executed by bash(1) for non-login shells
# (e.g. terminal emulator GUI apps or bash sub-shells)

# .bashrc sourcing order of operations:
# 1) Set PS1 bash prompt --------------------- .bash_profile (from dotfiles)
# 2) Source system-level script (if any) ----- /etc/bashrc
# 3) Set bash user aliases ------------------- .bashrc       (this script; from dotfiles)
# 4) Source OS-specific script (if any) ------ .bashrc.os.*  (from dotfiles)
# 5) Source machine-specific script (if any) - .bashrc.local

# Source system's global definitions
if [ -f /etc/bashrc ]; then
	# shellcheck disable=SC1091
	. /etc/bashrc
fi

# Enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
	if [ -r ~/.dircolors ]; then
		eval "$(dircolors -b ~/.dircolors)"
	else
		eval "$(dircolors -b)"
	fi

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
alias lsr='ls -alt'
alias lsrr='ls -alt | head -n15'
alias rmm="/bin/rm"
alias pss="ps aux | fgrep -v fgrep | fgrep"
alias count="wc"
if man which | grep -F read-alias >/dev/null; then alias which='alias | command which --tty-only --read-alias --show-dot --show-tilde'; fi

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

ifDistIsThenSource () {
	if [ "$#" -ne 2 ] || [ -z "$1" ] || [ -z "$2" ]; then
		echo "ERROR: ifDistIsThenSource needs two non-empty args" 1>&2
		echo "Usage: ifDistIsThenSource: Ubuntu ~/.bashrc.os.ubuntu" 1>&2
		return 1
	fi
	if ( which lsb_release 1>/dev/null 2>&1 && lsb_release -i | grep -F "$1" 1>/dev/null 2>&1 ); then
		if [ -r "$2" ]; then
			# shellcheck disable=SC1090
			. "$2"
		fi
	fi
}

# Bootstrap based on OS/Disto
ifDistIsThenSource "Raspbian" ~/.bashrc.os.raspbian

# Source user's local definitions
if [ -f ~/.bashrc.local ]; then
	# shellcheck disable=SC1090
	. ~/.bashrc.local
fi
