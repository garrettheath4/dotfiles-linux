# ~/.bash_profile: executed by bash(1) for login shells only
# (e.g. login via ssh or direct console login without GUI)

if [ -f ~/.bashrc ]; then
	# shellcheck disable=SC1091
	# shellcheck source=.bashrc
	source ~/.bashrc
fi

# Tmux-specific commands (only run if Tmux is installed)
if which tmux >/dev/null 2>&1; then
	# Automatically start Tmux session (or connect to an existing one) if this is not already a Tmux session
	if [ -z "${TMUX+defined}" ]; then
		if (tmux has-session 2>/dev/null); then
			tmux attach
		else
			tmux
		fi
	fi
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
