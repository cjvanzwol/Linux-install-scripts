#! /bin/bash

if [[ $UID != 0 ]]; then
  echo "This script must be run as root"
  exit 1
fi

lsblk | grep sd
read -p "What drive? /dev/sd[last letter] " LETTER
DRIVE=/dev/sd${LETTER}
n=1
create_file () {
	echo $n
	dd if=/dev/zero of=/mnt/data/test${n}.txt bs=100MB count=1
	n=$(( n + 1 ))
}

while true
do
  create_file
done
exit 1
