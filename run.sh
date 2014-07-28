#!/bin/bash

sudo docker run -d -v /sys/fs/cgroup:/sys/fs/cgroup:ro /usr/lib/systemd/systemd

