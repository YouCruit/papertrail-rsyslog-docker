#!/bin/sh -eux

papertrailHost="${PAPERTRAIL%%:*}"
papertrailPort="${PAPERTRAIL##*:}"

echo "Logging to $papertrailHost:$papertrailPort"
sed "s/PAPERTRAIL_HOST/$papertrailHost/g" "s/PAPERTRAIL_PORT/$papertrailPort/g" -i /etc/rsyslog.conf

exec /usr/sbin/rsyslogd -n
