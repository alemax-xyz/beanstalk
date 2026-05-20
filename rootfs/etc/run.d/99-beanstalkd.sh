set -- beanstalkd
[ -n "$BEANSTALK_WAL_DIR" ] && set -- "$@" -b "$BEANSTALK_WAL_DIR"
[ -n "$BEANSTALK_LISTEN_ADDR" ] && set -- "$@" -l "$BEANSTALK_LISTEN_ADDR"
[ -n "$BEANSTALK_LISTEN_PORT" ] && set -- "$@" -p "$BEANSTALK_LISTEN_PORT"
[ -n "$BEANSTALK_MAX_JOB_SIZE" ] && set -- "$@" -z "$BEANSTALK_MAX_JOB_SIZE"
[ -n "$BEANSTALK_WAL_FILE_SIZE" ] && set -- "$@" -s "$BEANSTALK_WAL_FILE_SIZE"
[ -n "$BEANSTALK_FSYNC_MS" ] && set -- "$@" -f "$BEANSTALK_FSYNC_MS"
[ "$BEANSTALK_FSYNC_NEVER" = 1 ] && set -- "$@" -F
[ "$BEANSTALK_VERBOSE" = 1 ] && set -- "$@" -V

suexec sudo -E -u "$PUSER" -g "$PGROUP" "$@"
