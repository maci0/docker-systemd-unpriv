docker-systemd-unpriv
=====================

Docker files for an unprivileged systemd container

This image is intended to be a base for other images.
To build it simply execute ./build.sh
To run a container simply execute ./run.sh

Example:

```
[root@mwysocki docker-systemd-unpriv]# ./build.sh 
Sending build context to Docker daemon  76.8 kB
Sending build context to Docker daemon 
Step 0 : FROM centos:centos7
 ---> ae0c2d0bdc10
Step 1 : MAINTAINER Marcel Wysocki "maci.stgn@gmail.com"
 ---> Using cache
 ---> bb4853dc1176
Step 2 : ENV container docker
 ---> Using cache
 ---> a48228da6706
Step 3 : RUN yum -y update; yum clean all
 ---> Using cache
 ---> 23b59b1a5888
Step 4 : RUN yum -y swap -- remove fakesystemd -- install systemd systemd-libs
 ---> Using cache
 ---> 18883c3a8b56
Step 5 : RUN systemctl mask dev-mqueue.mount dev-hugepages.mount     systemd-remount-fs.service sys-kernel-config.mount     sys-kernel-debug.mount sys-fs-fuse-connections.mount
 ---> Using cache
 ---> 1b634c72ffce
Step 6 : RUN systemctl mask display-manager.service systemd-logind.service
 ---> Using cache
 ---> e46df21a382d
Step 7 : RUN systemctl disable graphical.target; systemctl enable multi-user.target
 ---> Using cache
 ---> e5bf687364e2
Step 8 : ADD dbus.service /etc/systemd/system/dbus.service
 ---> Using cache
 ---> 9730bcba13be
Step 9 : VOLUME /sys/fs/cgroup
 ---> Using cache
 ---> dd013cf9b4b6
Step 10 : VOLUME /run
 ---> Using cache
 ---> 838484991d02
Step 11 : CMD /usr/lib/systemd/systemd
 ---> Using cache
 ---> 37f6f1fd1ec1
Successfully built 37f6f1fd1ec1
[root@mwysocki docker-systemd-unpriv]# ./run.sh 
Mon Jan 12 16:45:08 CET 2015
07504197ba03c7ddc8146f6582ad729fcd4e2e2753fdca9aa6f594af6be5190c
to enter docker container run: 
        docker exec -t -i 07504197ba03c7ddc8146f6582ad729fcd4e2e2753fdca9aa6f594af6be5190c /bin/bash
[root@mwysocki docker-systemd-unpriv]#         docker exec -t -i 07504197ba03c7ddc8146f6582ad729fcd4e2e2753fdca9aa6f594af6be5190c /bin/bash
[root@07504197ba03 /]# ps aux
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root         1  0.4  0.0  46904  4452 ?        Ss   15:45   0:00 /usr/lib/systemd/systemd
root        13  0.1  0.0  43000  6276 ?        Ss   15:45   0:00 /usr/lib/systemd/systemd-journald
dbus        23  0.0  0.0  26432   276 ?        Ss   15:45   0:00 /bin/dbus-daemon --system --fork
root        24  0.3  0.0  11748  2792 ?        S    15:45   0:00 /bin/bash
root        40  0.0  0.0  19756  2128 ?        R+   15:45   0:00 ps aux
[root@07504197ba03 /]# 
```
