# ~/.bashrc: executed by bash(1) for non-login shells
# (e.g. terminal emulator GUI apps or bash sub-shells)

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

ifDistIsThenSource () {
	if [ "$#" -ne 2 -o -z "$1" -o -z "$2" ]; then
		echo "ERROR: ifDistIsThenSource needs two non-empty args" 1>&2
		echo "Usage: ifDistIsThenSource: Ubuntu ~/.bashrc.os.ubuntu" 1>&2
		return 1
	fi
	if ( which lsb_release 2>/dev/null && lsb_release -i | fgrep "$1" 1>/dev/null 2>&1 ); then
		if [ ! -r "$2" ]; then
			echo "ERROR: OS bootstrap script $2 is not readable" 1>&2
			return 2
		else
			source "$2"
		fi
	fi
}

# Bootstrap based on OS/Disto
ifDistIsThenSource "Raspbian" ~/.bashrc.os.raspbian

# Source system's global definitions
if [ -f /etc/bashrc ]; then
	source /etc/bashrc
fi

# Source user's local definitions
if [ -f ~/.bashrc.local ]; then
	source ~/.bashrc.local
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
alias lsr='ls -alt'
alias lsrr='ls -alt | head -n15'
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

