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

# Set the editor to Vim if it is installed
if which vim >/dev/null 2>&1; then
	export EDITOR=$(which vim)
fi

# User aliases
alias lss="ls -Blah"
alias lsr='ls -alt'
alias lsrr='ls -alt | head -n15'
alias rmm="/bin/rm"
alias woman="man"
alias pss="ps aux | fgrep -v fgrep | fgrep"
alias count="wc"
if man which | grep -F read-alias >/dev/null; then alias which='alias | command which --tty-only --read-alias --show-dot --show-tilde'; fi

## SSH shortcuts
alias sshstu="ssh kollerg@condor.cs.wlu.edu"
alias sshcondor="ssh koller@condor.cs.wlu.edu"

## Git shortcuts
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

# Tmux-specific commands (only run if Tmux is installed)
if which tmux >/dev/null 2>&1; then
	# Automatically start Tmux session if this is an iTerm2 window with the Hotkey profile
	if [ "$ITERM_PROFILE" = "Hotkey" ] || [ "$ITERM_PROFILE" = "Hotkey Window" ] && [ -z "${TMUX+defined}" ]; then
		if (tmux has-session 2>/dev/null); then
			tmux attach
		else
			tmux
		fi
	fi

	# If this is a TMUX session, automatically run some commands
	if [ -n "${TMUX}" ]; then
		# TMUX_PANE=%0
		if [ "$TMUX_PANE" = '%0' ]; then
			tmux rename-window 'Local'
		fi

		# From article: https://blog.no-panic.at/2015/04/21/set-tmux-pane-title-on-ssh-connections/
		# Source Gist:  https://gist.github.com/florianbeer/ee02c149a7e25f643491
		ssh() {
			if [ "$(ps -p "$(ps -p $$ -o ppid=)" -o comm=)" = "tmux" ]; then
				if [ "$(tmux display-message -p '#W')" = "bash" ]; then
					# Tmux window doesn't have a custom name already, so proceed with auto-rename
					GrayTxt="$(tput setaf 0)"
					ResetColors="$(tput sgr0)"
					echo "${GrayTxt}Renaming Tmux window to match SSH session${ResetColors}" 1>&2
					windowName=$(echo "$1" | cut -d '.' -f 1)
					#TODO: Extract this known-server substitution into an optional .ssh_server_names.local definition file
					case "$windowName" in
						drlvapiapp01) windowName='Test_API'; ;;
						prlvapiapp01) windowName='PROD_API'; ;;
						drlvmtlapp01) windowName='MTool-Web'; ;;
					esac
					tmux rename-window "$windowName"
					#tmux set-window-option automatic-rename "on" 1>/dev/null
				else
					: # Tmux window has a custom name already, so don't rename it
				fi
			else
				echo "WARNING: Cannot rename the Tmux session because this is not a Tmux session.  This ssh() funcion shouldn't be defined.  Check your .bash_profile" 1>&2
			fi
			command ssh "$@"
		}
	fi
fi

cd_tmux() {
	# Usage: cd_tmux <DirToChangeTo> <NewTmuxWindowName>
	if [ "$#" -lt 2 ]; then
		echo 'Usage: cd_tmux <DirToChangeTo> <NewTmuxWindowName>'
		exit 1
	fi
	NewDir="$1"
	shift
	# Remaining arg(s) is new window name
	WindowName="$*"
	if which tmux >/dev/null 2>&1 && [ "$(ps -p "$(ps -p $$ -o ppid=)" -o comm=)" = "tmux" ] && [ "$(tmux display-message -p '#W')" = "bash" ]; then
		# Tmux is installed && this is a running Tmux session && the Tmux window has the default (non-custom) name
		GrayTxt="$(tput setaf 0)"
		ResetColors="$(tput sgr0)"
		echo "${GrayTxt}Renaming Tmux window to match current directory${ResetColors}" 1>&2
		tmux rename-window "$WindowName"
	fi
	# shellcheck disable=SC2164
	cd "$NewDir"
	pwd
}

