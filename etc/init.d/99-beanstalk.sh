[ -z "$BEANSTALK_WAL_DIR" ] && BEANSTALK_WAL_DIR="/var/lib/beanstalkd"

[ -e "$BEANSTALK_WAL_DIR" ] || suexec mkdir -p "$BEANSTALK_WAL_DIR" || exit $?
suexec chown -R $PUID:$PGID "$BEANSTALK_WAL_DIR" || exit $?

export BEANSTALK_WAL_DIR

su -p -s /bin/sh -c 'cat > /etc/environment.d/99-beanstalk.conf' <<-EOF
	BEANSTALK_WAL_DIR="$BEANSTALK_WAL_DIR"
EOF
