# ~/.bashrc: executed by bash(1) for non-login shells
# (e.g. terminal emulator GUI apps or bash sub-shells)

# .bashrc sourcing order of operations:
# 1) Source system-level script (if any) ----- /etc/bashrc
# 2) Set PS1 bash prompt and user aliases ---- .bashrc       (this script; from dotfiles)
# 3) Source OS-specific script (if any) ------ .bashrc.os.*  (from dotfiles)
# 4) Source machine-specific script (if any) - .bashrc.local

# Source system's global definitions
if [ -f /etc/bashrc ]; then
	# shellcheck disable=SC1091
	. /etc/bashrc
fi

# Set a custom color-enabled Bash command prompt string
# (the \[ and \] in YellowBgPS, BlackFgPS, and ResetColorsPS indicate that those characters are
# unprintable and to not include them in the string width counting)
# Bash Prompt Customization: https://wiki.archlinux.org/index.php/Bash/Prompt_customization
# Terminal Codes intro: http://wiki.bash-hackers.org/scripting/terminalcodes
# Original PS1="[\u@\h \W]\$ "
YellowBgPS="\[$(tput setab 3)\]"
BlackFgPS="\[$(tput setaf 0)\]"
ResetColorsPS="\[$(tput sgr0)\]"
export PS1="${YellowBgPS}${BlackFgPS}[\u@\h:\W]${ResetColorsPS}\$ "


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
		if [ ! -r "$2" ]; then
			echo "ERROR: OS bootstrap script $2 is not readable" 1>&2
			return 2
		else
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
