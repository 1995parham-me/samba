#!/bin/bash

set -eu
set -o pipefail

main() {
	if [ $# != 1 ]; then
		return 1
	fi

	case $1 in
	"start")
		sudo systemctl start smb.service nmb.service
		;;
	"stop")
		sudo systemctl stop smb.service nmb.service
		;;
	*)
		return 1
		;;
	esac
}

main "$*"
