#!/bin/bash

sudo docker run --rm -t -i -v /sys/fs/cgroup:/sys/fs/cgroup:ro maci/systemd /usr/lib/systemd/systemd


