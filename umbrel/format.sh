#! /bin/bash

if [[ $UID != 0 ]]; then
  echo "This script must be run as root"
  exit 1
fi

rm /home/umbrel/*.gb
lsblk | grep sd
read -p "What drive? /dev/sd[last letter] " LETTER
DRIVE=/dev/sd${LETTER}
SUCCES=true
read -p "Partition one drive or run test lager sizes? [1 for 1/other for test] " nxt
read -p "How many GB? (start size when testing) " SIZE

format () {
echo "Trying ${SIZE}GB"
umount ${DRIVE}1
touch /home/umbrel/${SIZE}.gb
parted $DRIVE mklabel gpt
parted $DRIVE mkpart primary 0GB ${SIZE}GB
sleep 1
mkfs.ext4 ${DRIVE}1
mount ${DRIVE}1 /mnt/data || SUCCES=false
if $SUCCES; then
  mkdir -p /mnt/data/umbrel
  source test.sh
  source speed.sh $DRIVE
fi
SIZE=$(( $SIZE * 10 ))
}

while $SUCCES; do
  format
  [[ $nxt == "1" ]] && exit 1
done

echo ""
echo ""
ls -hal ~
exit 0
