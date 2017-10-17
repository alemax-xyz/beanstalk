#!/bin/sh

test -z "$PUID" && PUID=50 || test "$PUID" -eq "$PUID" || exit 2
PUSER=$(getent passwd $PUID | cut -d: -f1)
test -n "$PUSER" || PUSER=$(getent passwd 50 | cut -d: -f1) && usermod --uid $PUID "$PUSER" || exit 2

test -z "$PGID" && PGID=$(id -g "$PUSER") || test "$PGID" -eq "$PGID" || exit 2
PGROUP=$(getent group $PGID | cut -d: -f1)
if [ -z "$PGROUP" ]; then
    PGROUP=$(id -gn "$PUSER")
    groupmod --gid $PGID "$PGROUP" || exit 2
else
    test $(id -g "$PUSER") -eq $PGID || usermod --gid $PGID "$PUSER" || exit 2
fi

chown $PUID:$PGID -R /var/lib/beanstalkd || exit 2

beanstalkd \
    -b /var/lib/beanstalkd \
    -u "$PUSER" \
    $(test -n "$FSYNC_MS" && echo -f $FSYNC_MS) \
    $(test -n "$MAX_JOB_SIZE" && echo -z $MAX_JOB_SIZE) \
    $(test -n "$WAL_FILE_SIZE" && echo -s $WAL_FILE_SIZE) \
    $(test -n "${DONT_COMPACT_BINLOG+1}" && echo -n) \
    $(test -n "${VERBOSE+1}" && echo -V)
