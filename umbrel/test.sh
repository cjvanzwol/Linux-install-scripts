#! /bin/bash

if [[ $UID != 0 ]]; then
  echo "This script must be run as root"
  exit 1
fi

lsblk | grep sd
read -p "What drive? /dev/sd[last letter] " LETTER
DRIVE=/dev/sd${LETTER}
n=1
again=true
create_file () {
	dd if=/dev/zero of=/mnt/data/test${n}.txt bs=100MB count=1 || again=false
	n=$(( n + 1 ))
}

while $again
do
  create_file
done
echo ""
echo ""
du -sh /mnt/data
exit 1
