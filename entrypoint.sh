#!/bin/sh

# generate host keys if not present
ssh-keygen -A

# add borg user if not present
if ! id -u borg > /dev/null 2>&1; then
    adduser -D -u 1000 borg
    echo "borg:${BORG_USER_PASS}" | chpasswd
fi

# do not detach (-D), log to stderr (-e), passthrough other arguments
exec /usr/sbin/sshd -D -e "$@"
