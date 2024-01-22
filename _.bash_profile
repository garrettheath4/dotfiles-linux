# ~/.bash_profile: executed by bash(1) for login shells only
# (e.g. login via ssh or direct console login without GUI)

# Set a custom color-enabled Bash command prompt string
# (the \[ and \] in YellowBgPS, BlackFgPS, and ResetColorsPS indicate that those characters are
# unprintable and to not include them in the string width counting)
# Bash Prompt Customization: https://wiki.archlinux.org/index.php/Bash/Prompt_customization
# Terminal color codes table: see _Color Handling_ section in `man terminfo`
# Original PS1="[\u@\h \W]\$ "
BlackFgPS="\[$(tput setaf 0)\]"
RedBgPS="\[$(tput setab 1)\]"     # PROD
GreenBgPS="\[$(tput setab 2)\]"   # DEV
YellowBgPS="\[$(tput setab 3)\]"  # TEST
BlueBgPS="\[$(tput setab 4)\]"    # STAG
MagentaBgPS="\[$(tput setab 5)\]" # unknown
ResetColorsPS="\[$(tput sgr0)\]"
if [ "$DEPLOYMENT_ENV" == dev ]; then
>---export PS1="${GreenBgPS}${BlackFgPS}[\u@\h:\W]${ResetColorsPS}\$ "
elif [ "$DEPLOYMENT_ENV" == test ]; then
>---export PS1="${YellowBgPS}${BlackFgPS}[\u@\h:\W]${ResetColorsPS}\$ "
elif [ "$DEPLOYMENT_ENV" == stag ]; then
>---export PS1="${BlueBgPS}${BlackFgPS}[\u@\h:\W]${ResetColorsPS}\$ "
elif [ "$DEPLOYMENT_ENV" == prod ]; then
>---export PS1="${RedBgPS}${BlackFgPS}[\u@\h:\W]${ResetColorsPS}\$ "
else
>---export PS1="${MagentaBgPS}${BlackFgPS}[\u@\h:\W]${ResetColorsPS}\$ "
fi

if [ -f ~/.bashrc ]; then
	# shellcheck disable=SC1090
	. ~/.bashrc
fi

if [ -f /etc/motd ]; then
	cat /etc/motd
fi


# vim: set ft=sh:
