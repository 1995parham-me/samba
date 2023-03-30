#!/bin/bash

export F_CYAN="\033[38;2;0;255;255m"
export F_GREEN="\033[38;2;127;230;127m"
export F_RED="\033[38;2;255;127;127m"
export F_ORANGE="\033[38;2;255;165;0m"
export F_YELLOW="\033[38;2;255;255;25m"
export F_GRAY="\033[38;2;90;90;90m"
export F_BLUE="\033[38;2;0;191;255m"
export BOLD_ON="\033[1m"
export BOLD_OFF="\033[0m"
export F_RESET="\033[39m"

function message() {
	local module=samba
	local message=$1
	local servity=${2:-"info"}

	case $servity in
	info)
		servity=""
		;;
	error)
		servity="${F_RED}${BOLD_ON} (error) ${F_RESET}${BOLD_OFF}"
		;;
	*)
		servity=""
		;;
	esac

	echo -e "$servity${F_CYAN}[$module] ${F_ORANGE}$message $F_RESET"
}

function running() {
	local module=$1
	shift

	echo -e "${F_YELLOW}[$module] ${F_ORANGE}⇒ $* $F_RESET"
}

function action() {
	local module=$1
	shift

	echo -e "${F_RED}[$module] ${F_ORANGE}⇒ $* $F_RESET"
}

install-samba() {
	pkg="samba"

	running "require" " pacman $pkg"
	if ! pacman -Qi "$pkg" &>/dev/null; then
		action "require" "勒pacman -Sy $pkg"
		sudo pacman -Sy --noconfirm "$pkg"
	fi
}

main() {
	install-samba

	message "Although the user name is shared with Linux system, Samba uses a password separate from that of the Linux user accounts."
	smbpasswd -a parham
}

main "$*"
