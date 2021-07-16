for i in 1 2 3; do hdparm -I /dev/sd${1}1 | grep -i speed;done
