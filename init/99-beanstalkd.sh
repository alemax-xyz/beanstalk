#!/bin/sh

beanstalkd \
	-b /var/lib/beanstalkd \
	-u "$PUSER" \
	$(test -n "$FSYNC_MS" && echo -f $FSYNC_MS) \
	$(test -n "$MAX_JOB_SIZE" && echo -z $MAX_JOB_SIZE) \
	$(test -n "$WAL_FILE_SIZE" && echo -s $WAL_FILE_SIZE) \
	${DONT_COMPACT_BINLOG:+-n} \
	${VERBOSE:+-V}
