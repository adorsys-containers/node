#!/bin/bash

set -euo pipefail

if [ -f /sys/fs/cgroup/cgroup.controllers ]; then
  MEMORY=$(cat /sys/fs/cgroup/memory.max)
elif [ -f /sys/fs/cgroup/memory/memory.limit_in_bytes ]; then
  MEMORY=$(cat /sys/fs/cgroup/memory/memory.limit_in_bytes)
else
  MEMORY=9223372036854771712
fi

if [ "${MEMORY}" != "max" ] && [ "${MEMORY}" != "9223372036854771712" ]; then
  if [ "${NODE_MEMORY_LIMIT_PERCENT}" -lt 1 ] || [ "${NODE_MEMORY_LIMIT_PERCENT}" -gt 100 ]; then
    echo "\$NODE_MEMORY_LIMIT_PERCENT should be between 1 and 99."
    exit 1
  fi

  NODE_OPTIONS="--max_old_space_size=$(( MEMORY * NODE_MEMORY_LIMIT_PERCENT / 100 / 1000 / 1000 )) ${NODE_OPTIONS:-}"
  export NODE_OPTIONS
fi

unset MEMORY

# From https://docs.openshift.com/container-platform/3.9/creating_images/guidelines.html#use-uid
if ! whoami > /dev/null 2>&1; then
  if [ -w /etc/passwd ]; then
    echo "${USER_NAME:-default}:x:$(id -u):0:${USER_NAME:-default} user:${HOME}:/sbin/nologin" >> /etc/passwd
  fi
fi

if [ -d /docker-entrypoint.d/ ] && [ -n "$(ls -A /docker-entrypoint.d/)" ]; then
  for f in /docker-entrypoint.d/*; do
    # shellcheck source=/dev/null
    . "$f"
  done
fi

exec "$@"
