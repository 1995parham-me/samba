#!/bin/bash

# https://stackoverflow.com/questions/3822621/how-to-exit-if-a-command-failed
set -eu
set -o pipefail

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

samba_root="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

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
	if [ $# != 1 ]; then
		message "invalid command" "error"
		return 1
	fi

	case $1 in
	"install")
		install-samba

		testparm "$samba_root/smb.conf"
		sudo cp "$samba_root/smb.conf" /etc/samba/smb.conf

		message "Although the user name is shared with Linux system, Samba uses a password separate from that of the Linux user accounts."
		sudo smbpasswd -a parham
		;;
	"start")
		sudo systemctl start smb.service nmb.service
		;;
	"stop")
		sudo systemctl stop smb.service nmb.service
		;;
	*)
		message "invalid command" "error"
		return 1
		;;
	esac
}

main "$*"
