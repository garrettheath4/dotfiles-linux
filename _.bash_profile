# ~/.bash_profile: executed by bash(1) for login shells only
# (e.g. login via ssh or direct console login without GUI)

if [ -f ~/.bashrc ]; then
	# shellcheck disable=SC1090
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

