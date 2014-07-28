#!/bin/bash

sudo docker run --rm -t -i -v /sys/fs/cgroup:/sys/fs/cgroup:ro -v /tmp/$(mktemp -d):/run maci/systemd /usr/lib/systemd/systemd
