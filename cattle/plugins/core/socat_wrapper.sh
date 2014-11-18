#!/bin/bash
set -e

socat "$@" &
PID=$!

cleanup()
{
    if [ -e /proc/$PID ]; then
        kill -9 $PID >/dev/null 2>&1 || true
    fi
}

trap cleanup exit

while sleep 5; do
    if [[ ! -e /proc/$PPID || ! -e /proc/$PID ]]; then
        cleanup
        exit 1
    fi
done
