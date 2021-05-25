#!/bin/sh

chown -R $PUID:$PGID /var/lib/beanstalkd || exit 2
