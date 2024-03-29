# vim: set ft=sh:
# shellcheck shell=bash
#
# ~/.bashrc: executed by bash(1) for non-login shells
# (e.g. terminal emulator GUI apps or bash sub-shells)

# .bashrc sourcing order of operations:
# 1) Source machine-specific before script (if any) - .bash_profile.local.before
# 2) Set PS1 bash prompt ---------------------------- .bash_profile (from dotfiles)
# 3) Source system-level script (if any) ------------ /etc/bashrc
# 4) Set bash user aliases -------------------------- .bashrc (THIS SCRIPT; from dotfiles)
# 5) Source OS-specific script (if any) ------------- .bashrc.os.*  (from dotfiles)
# 6) Source machine-specific script (if any) -------- .bashrc.local

# If not running interactively (e.g. scp), don't do anything
# Source; https://stackoverflow.com/a/40956958/1360295
case $- in
	*i*) ;;
	*) return;;
esac

# Source system's global definitions
if [ -f /etc/bashrc ]; then
	# shellcheck disable=SC1091
	. /etc/bashrc
fi

# Add user bin and sbin folders to PATH
# [[ is not POSIX compatible so using alternative from https://stackoverflow.com/a/20460402/1360295
if [ -d "$HOME/bin" ] && [ -n "${PATH##*$HOME/bin*}" ]; then
	export PATH="$PATH:$HOME/bin"
fi

if [ -d "$HOME/sbin" ] && [ -n "${PATH##*$HOME/sbin*}" ]; then
	export PATH="$PATH:$HOME/sbin"
fi

export VISUAL=vim

# Tmux-specific commands (only run if Tmux is installed)
# This should go at the top of .bash_profile since we don't need to worry about
# setting up THIS shell if we're just going to launch Tmux with its own shell so
# setting up THIS shell doesn't matter if Tmux is installed (until Tmux exits)
if command -v tmux >/dev/null 2>&1; then
	# Tmux is installed
	if [ -z "${TMUX+defined}" ]; then
		# This is NOT a Tmux session
		if [ "$ITERM_PROFILE" = "Hotkey" ] || [ "$ITERM_PROFILE" = "Hotkey Window" ]; then
			# This is an iTerm2 window with the Hotkey profile
			tmux-name
		else
			echo "==> Don't forget to run tmux-name <=="
		fi
	else
		# This IS a Tmux session
		alias ssh='ssh-name'
	fi
fi

# shellcheck source=../.git-completion.bash disable=SC1091
test -f ~/.git-completion.bash -a -x ~/.git-completion.bash && . "$_"

# Enable Bash completion scripts from Homebrew installs if Homebrew and Homebrew:bash-completion are installed
# bash-completion can be installed with: brew install bash-completion
# shellcheck source=/usr/local/etc/bash_completion disable=SC1091
(command -v brew >/dev/null 2>&1) && test -f "$(brew --prefix)/etc/bash_completion" && . "$_"

# Enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
	if [ -r ~/.dircolors ]; then
		eval "$(dircolors -b ~/.dircolors)"
	else
		eval "$(dircolors -b)"
	fi

	alias ls='ls --color=always'

	alias grep='grep --color=always'
	alias fgrep='fgrep --color=always'
	alias egrep='egrep --color=always'
fi

# Set the editor to Vim if it is installed
if which vim >/dev/null 2>&1; then
	EDITOR=$(which vim)
	export EDITOR
	alias vimro="vim -RMn"
fi

# User aliases
if man which | grep -F read-alias >/dev/null; then alias which='alias | command which --tty-only --read-alias --show-dot --show-tilde'; fi
alias lss='ls -alhB'
alias lsr='ls -alht'
alias lsrr='lsr | head -n15'
alias rmm='command rm'
alias pss='ps aux | head -n1; ps aux | fgrep -v grep | fgrep'
alias topp='top -u -R -s 2 -stats user,pid,command,cpu,time,state,th,csw,ports,vsize'
alias woman='man'
alias reverse='tail -r'
alias reload='source ~/.bashrc'
alias incognito='unset HISTFILE'
alias ports='ss -tulp'

## Git shortcuts
alias ggp='git-pull-push'
alias ggu='git-branches-status'
alias ggb='git branch'
alias ggs='git status'
alias ggd='git diff'
alias ggdi='git diff --word-diff'
alias gga='git add'
alias ggc='git commit -m'
alias ggl='git log --pretty=oneline --abbrev-commit'

## Other terminal shortcuts
alias ag='ag --color'
alias mvnt='mvn dependency:tree -Dverbose | vim "+set bt=nofile" -'
alias docker-clean='docker rm $(docker ps -a -q); docker rmi $(docker images -q)'
# If youtube-dl is installed be sure to also install ffmpeg with 'apt install ffmpeg'
# Alias source: https://github.com/rg3/youtube-dl/issues/8017#issuecomment-167382308
alias youtube-dl='echo "youtube-dl -f bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best"; youtube-dl -f bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best'

ifDistIsThenSource () {
	if [ "$#" -ne 2 ] || [ -z "$1" ] || [ -z "$2" ]; then
		echo "ERROR: ifDistIsThenSource needs two non-empty args" 1>&2
		echo "Usage: ifDistIsThenSource: Ubuntu ~/.bashrc.os.ubuntu" 1>&2
		return 1
	fi
	if ( which lsb_release 1>/dev/null 2>&1 && lsb_release -i | grep -F "$1" 1>/dev/null 2>&1 ) || grep -F "$1" /etc/os-release; then
		if [ -r "$2" ]; then
			# shellcheck disable=SC1090
			. "$2"
		fi
	fi
}

# Bootstrap based on OS/Disto
ifDistIsThenSource "Raspbian" ~/.bashrc.os.raspbian

# Source user's local definitions
# I recommend putting a custom command prompt in .bash_profile.local
# like: export PS1="\u@\h:\W$(tput sgr0) \$ "
if [ -f ~/.bashrc.local ]; then
	# shellcheck disable=SC1090
	source ~/.bashrc.local
fi
