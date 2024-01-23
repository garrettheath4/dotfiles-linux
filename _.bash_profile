# vim: set ft=sh:
# shellcheck shell=bash
#
# ~/.bash_profile: executed by bash(1) for login shells only
# (e.g. login via ssh or direct console login without GUI)

if [ -f ~/.bash_profile.local.before ]; then
	# shellcheck disable=SC1090
	source ~/.bash_profile.local.before
fi

colorize_prompt() {
	# Set a custom color-enabled Bash command prompt string
	# (the \[ and \] in PSBgYel, PSFgBlk, and PSResetColors indicate that those characters are
	# unprintable and to not include them in the string width counting)
	# Bash Prompt Customization: https://wiki.archlinux.org/index.php/Bash/Prompt_customization
	# Terminal color codes table: see _Color Handling_ section in `man terminfo`
	# Original PS1="[\u@\h \W]\$ "

	# Background (highlight) colors
	local PSBgRed; PSBgRed="\[$(tput setab 1)\]"  # PROD
	local PSBgGrn; PSBgGrn="\[$(tput setab 2)\]"  # DEV
	local PSBgYel; PSBgYel="\[$(tput setab 3)\]"  # TEST
	local PSBgBlu; PSBgBlu="\[$(tput setab 4)\]"  # STAG
	local PSBgMag; PSBgMag="\[$(tput setab 5)\]"  # unknown

	# Foreground (font) colors
	local PSFgBlk; PSFgBlk="\[$(tput setaf 0)\]"  # black foreground (font)
	local PSFgWht; PSFgWht="\[$(tput setaf 7)\]"  # white foreground (font)

	# Reset background and foreground colors to default
	local PSResetColors; PSResetColors="\[$(tput sgr0)\]"

	PSFgColor="$PSFgBlk"
	if [ "$DEPLOYMENT_ENV" == dev ]; then
		PSBgColor="$PSBgGrn"
	elif [ "$DEPLOYMENT_ENV" == test ]; then
		PSBgColor="$PSBgYel"
	elif [ "$DEPLOYMENT_ENV" == stag ]; then
		PSBgColor="$PSBgBlu"
	elif [ "$DEPLOYMENT_ENV" == prod ]; then
		PSBgColor="$PSBgRed"
		PSFgColor="$PSFgWht"
	else
		# Consider adding `export DEPLOYMENT_ENV=dev` to `~/.bash_profile.local.before`
		PSBgColor="$PSBgMag"
	fi

	export PS1="${PSBgColor}${PSFgColor}[\u@\h:\W]${PSResetColors}\$ "
}

colorize_prompt

if [ -f ~/.bashrc ]; then
	# shellcheck disable=SC1090
	source ~/.bashrc
fi

if [ -f /etc/motd ]; then
	cat /etc/motd
fi
