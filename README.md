docker-systemd-unpriv
=====================

Docker files for an unprivileged systemd container based on CentOS 7.

This image is intended to be a base for other images.

To build it simply execute ```./build.sh```

To run a container simply execute ```./run.sh```

Example:

```
[root@mwysocki docker-systemd-unpriv]# ./build.sh
Sending build context to Docker daemon 122.4 kB
Sending build context to Docker daemon
Step 0 : FROM centos:centos7
 ---> 7322fbe74aa5
Step 1 : MAINTAINER Marcel Wysocki "maci.stgn@gmail.com"
 ---> Using cache
 ---> 00c8b93cf714
Step 2 : ENV container docker
 ---> Using cache
 ---> 9b8f4fb8200a
Step 3 : RUN yum -y update; yum clean all
 ---> Using cache
 ---> 3345a7b137ca
Step 4 : RUN yum -y swap -- remove systemd-container systemd-container-libs -- install systemd systemd-libs dbus
 ---> Using cache
 ---> b96655caefbc
Step 5 : RUN systemctl mask dev-mqueue.mount dev-hugepages.mount     systemd-remount-fs.service sys-kernel-config.mount     sys-kernel-debug.mount sys-fs-fuse-connections.mount     display-manager.service graphical.target systemd-logind.service
 ---> Running in 15346731ae25
 ---> 1ee09b86a67b
Removing intermediate container 15346731ae25
Step 6 : ADD dbus.service /etc/systemd/system/dbus.service
 ---> 30046edacbd0
Removing intermediate container 84556db3d846
Step 7 : RUN systemctl enable dbus.service
 ---> Running in 151ced2a823e
 ---> fd86e74cf704
Removing intermediate container 151ced2a823e
Step 8 : VOLUME /sys/fs/cgroup
 ---> Running in bd81371550ca
 ---> 1c888d9613f8
Removing intermediate container bd81371550ca
Step 9 : VOLUME /run
 ---> Running in 1bcb2d277021
 ---> de4f43ca3837
Removing intermediate container 1bcb2d277021
Step 10 : CMD /usr/lib/systemd/systemd
 ---> Running in b660c5d8cba6
 ---> 1d7ff7bdbd64
Removing intermediate container b660c5d8cba6
Successfully built 1d7ff7bdbd64
[root@mwysocki docker-systemd-unpriv]# ./run.sh
Wed Jul 29 17:11:14 CEST 2015
1302a1dbd5ff09e720c566ea6b87f1233f0cc14370022a900bdc84e8d07a27f5
To enter docker container run:
        docker exec -t -i 1302a1dbd5ff09e720c566ea6b87f1233f0cc14370022a900bdc84e8d07a27f5 /bin/bash
[root@mwysocki docker-systemd-unpriv]#         docker exec -t -i 1302a1dbd5ff09e720c566ea6b87f1233f0cc14370022a900bdc84e8d07a27f5 /bin/bash
[root@1302a1dbd5ff /]# ps -ux
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root         1  0.7  0.0  53584  3328 ?        Ss   15:11   0:00 /usr/lib/systemd/systemd
root        14  0.1  0.0  43024  5232 ?        Ss   15:11   0:00 /usr/lib/systemd/systemd-journald
root        24  0.4  0.0  11748  1940 ?        Ss   15:11   0:00 /bin/bash
root        39  0.0  0.0  19772  1476 ?        R+   15:11   0:00 ps -ux
[root@1302a1dbd5ff /]#
```

As an alternative you can get a pre-built container:
```docker pull maci0/systemd```
Or just run it using the default docker command (this should pull the image automatically):
```docker run -v /sys/fs/cgroup:/sys/fs/cgroup:ro maci0/systemd```
For more information see: https://registry.hub.docker.com/u/maci0/systemd/ or http://www.docker.com
