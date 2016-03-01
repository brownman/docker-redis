#!/bin/bash
set -e

sysctl -w net.core.somaxconn=4096

# allow the container to be started with `--user`
if [ "$1" = 'redis-server' -a "$(id -u)" = '0' ]; then
  chown -R redis .
  exec gosu redis "$BASH_SOURCE" "$@"
fi

exec "$@"