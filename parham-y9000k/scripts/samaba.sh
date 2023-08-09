#!/bin/bash
usage() {
	echo "Samba is the standard Windows interoperability suite of programs for Linux and Unix"

	# shellcheck disable=1004,2016
	echo '
                           _
 ___  __ _ _ __ ___   __ _| |__   __ _
/ __|/ _` | |_ ` _ \ / _` | |_ \ / _` |
\__ \ (_| | | | | | | (_| | |_) | (_| |
|___/\__,_|_| |_| |_|\__,_|_.__/ \__,_|
  '
}

root=${root:?"root must be set"}

main_pacman() {
	return 1
}

main_apt() {
	return 1
}

main_brew() {
	return 1
}

main() {
	return 0
}

main_parham() {
	testparm "$root/smb.conf"
	copycat "samba" "smb.conf" /etc/samba/smb.conf

	msg "Although the user name is shared with Linux system, Samba uses a password separate from that of the Linux user accounts."
	sudo smbpasswd -a parham
}
