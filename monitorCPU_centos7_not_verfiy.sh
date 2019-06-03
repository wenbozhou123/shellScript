#!/bin/bash
DATE=$(date +%F %H:%M)
IP=$(ifconfig ens32 | awk -F '[ :]+' '/inet / {print $3}') #centos7
#IP=$(ifconfig eth0 | awk -F '[ :]+' '/inet / {print $3}') #centos6
MAIL="example@mail.com"

if ! which vmstat &>/dev/null; then
	echo "vmstat command not fount, pls install it"
	exit 1
fi

US=$(vmstat | awk 'NR==3{print $13}')
Y=$(vmstat | awk 'NR==3{print $14}')
IDLE=$(vmstat | awk 'NR==3{print $15}')
WAIT=$(vmstat | awk 'NR==3{print $16}')
USE=$(($US+$SY))
if [ $USE -ge 50 ]; then
	echo "
        Date: $DATE
        Host: $IP
        Problem: CPU utilization $USE
        " | mail -s "CPU Monitor" $MAIL
fi


