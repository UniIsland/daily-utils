#!/bin/bash

USER=mazelord

if [[ $UID -ne 0 ]]; then
	echo "become root to run this script."
	exit 1
fi

su $USER -c 'kdialog --display :0 --title "Time For Battery" --sorry "Is the battery inserted?"' &
PID="` ps -C kdialog | grep "kdialog" | awk '{ print $1 }' `"
sleep 25
[[ `ps -p $PID | grep "kdialog"` ]] || exit 0
kill $PID
su $USER -c 'kdialog --display :0 --title "Time For Battery" --error "You missed the warning!"' &

modprobe pcspkr
echo -e "\a" > /dev/tty10
sleep 1
echo -e "\a" > /dev/tty10
sleep 1
modprobe -r pcspkr

exit 1