#!/bin/bash

TMPDIR=$(mktemp -d)
NAME=docker-systemd-$(echo ${TMPDIR}|cut -d\. -f2)
sudo docker run --name=${NAME} --rm -t -i -v /sys/fs/cgroup:/sys/fs/cgroup:ro -v /${TMPDIR}/run:/run maci/systemd /usr/lib/systemd/systemd
