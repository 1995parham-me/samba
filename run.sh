#!/bin/bash

set -eu
set -o pipefail

main() {
	if [ $# != 1 ]; then
		set --first "status"
	fi

	case $1 in
	"start")
		sudo systemctl start smb.service nmb.service
		;;
	"stop")
		sudo systemctl stop smb.service nmb.service
		;;
	*)
		sudo systemctl status smb.service
		;;
	esac
}

main "$*"
