set -- beanstalkd \
	-b "${BEANSTALK_WAL_DIR:=-/var/lib/beanstalkd}" \
	-l "${BEANSTALK_LISTEN_ADDR:-0.0.0.0}" \
	-p "${BEANSTALK_LISTEN_PORT:-11300}" \
	-z "${BEANSTALK_MAX_JOB_SIZE:-65536}" \
	-s "${BEANSTALK_WAL_FILE_SIZE:-10485760}"
[ -n "$BEANSTALK_FSYNC_MS" ] && set -- "$@" -f "$BEANSTALK_FSYNC_MS"
[ "$BEANSTALK_FSYNC_NEVER" = 1 ] && set -- "$@" -F
[ "$BEANSTALK_VERBOSE" = 1 ] && set -- "$@" -V

suexec sudo -E -u "$PUSER" -g "$PGROUP" "$@"
