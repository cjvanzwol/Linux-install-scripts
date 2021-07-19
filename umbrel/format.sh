#! /bin/bash

if [[ $UID != 0 ]]; then
  echo "This script must be run as root"
  exit 1
fi

rm /home/umbrel/*.gb
lsblk | grep sd
read -p "What drive? /dev/sd[last letter] " LETTRE
DRIVE=/dev/sd${LETTRE}
SUCCES=true
read -p "Partition one drive or run test lager sizes? [1 for 1/other for test] " nxt
read -p "How many GB? (start size when testing) " SIZE
read -p "Resize to max after format? [y/n] " RESIZE
read -p "Debug? [y/n] " DEBUG

pause () {
  [[ $DEBUG == "y" ]] && read -p "DEBUG" d
}

check_repair () {
  sleep 1
  umount ${DRIVE}1
  sleep 1
  fsck.ext4 -v ${DRIVE}1 -y && e2fsck -b 32768 ${DRIVE}1 -y
}

format () {
echo "Trying ${SIZE}GB"
umount ${DRIVE}1
touch /home/umbrel/${SIZE}.gb
parted $DRIVE mklabel gpt
parted $DRIVE mkpart primary 0GB ${SIZE}GB
sleep 1
mkfs.ext4 ${DRIVE}1
pause
check_repair
pause
mount ${DRIVE}1 /mnt/data || SUCCES=false
pause
if $SUCCES; then
  mkdir -p /mnt/data/umbrel
  touch /mnt/data/umbel/.umbrel
  #source test.sh
  #source speed.sh $LETTRE
fi
if [[ $RESIZE == "y" ]]; then
  umount ${DRIVE}1
  pause
  parted ${DRIVE} resizepart 1 2000GB
  pause
  check_repair
  SIZE=$(( $SIZE * 10 ))
fi
}

while $SUCCES; do
  format
  [[ $nxt == "1" ]] && exit 1
done

echo ""
echo ""
ls -hal ~
echo ""
ls -hal /mnt/data
exit 0
