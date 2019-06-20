# ~/.bash_profile: executed by bash(1) for login shells only
# (e.g. login via ssh or direct console login without GUI)

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

if [ -f ~/.bashrc ]; then
	# shellcheck disable=SC1090
	. ~/.bashrc
fi

if [ -f /etc/motd ]; then
	cat /etc/motd
fi


# vim: set ft=sh:
