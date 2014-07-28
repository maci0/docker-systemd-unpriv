#!/bin/bash

sudo docker run -d -v /sys/fs/cgroup:/sys/fs/cgroup:ro -v /tmp/$(mktemp -d):/run /usr/lib/systemd/systemd

