#!/bin/bash
usage() {
  echo "Samba is the standard Windows interoperability suite of programs for Linux and Unix"

  # shellcheck disable=1004,2016
  echo '
                     _
 ___  __ _ _ __ ___ | |__   __ _
/ __|/ _` | |_ ` _ \| |_ \ / _` |
\__ \ (_| | | | | | | |_) | (_| |
|___/\__,_|_| |_| |_|_.__/ \__,_|
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
  return 0
}
