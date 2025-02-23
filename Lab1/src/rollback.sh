#!/bin/bash

for user in u1 u2 myuser; do
    if id "$user" &>/dev/null; then
        userdel -r "$user"
        echo "The user $user has been deleted."
    fi
done

for group in g1 task14; do
    if getent group "$group" >/dev/null; then
        groupdel "$group"
        echo "The $group has been deleted."
    fi
done

if [ -f /etc/skel/readme.txt ]; then
    if grep -q "Be careful!" /etc/skel/readme.txt; then
        rm -f /etc/skel/readme.txt
        echo "/etc/skel/readme.txt removed."
    fi
fi

rm -f work3.log
for dir in /home/test13 /home/test14 /home/test15; do
    if [ -d "$dir" ]; then
        rm -rf "$dir"
        echo "The $dir directory has been deleted."
    fi
done

if [ -f /etc/sudoers.d/u1-passwd ]; then
    rm -f /etc/sudoers.d/u1-passwd
    echo "The /etc/sudoers.d/u1-passwd file has been removed."
fi

