#!/bin/bash

sudo docker run -d -v /sys/fs/cgroup:/sys/fs/cgroup:ro maci/systemd /usr/lib/systemd/systemd

