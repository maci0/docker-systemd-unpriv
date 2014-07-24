#!/bin/bash

TMPDIR=$(mktemp -d)
NAME=$(echo ${TMPDIR}|cut -d\. -f2)
sudo docker run --hostname=${NAME}.local --name=${NAME} -d -v /sys/fs/cgroup:/sys/fs/cgroup:ro \
-v /${TMPDIR}/run:/run maci/systemd /usr/lib/systemd/systemd

