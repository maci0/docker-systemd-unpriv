FROM centos:centos7
MAINTAINER Marcel Wysocki "maci.stgn@gmail.com"
ENV container docker

RUN yum -y update
RUN yum -y install passwd openssh-server
RUN yum clean all
RUN echo root | passwd --stdin root
RUN echo "UseDNS no" >> /etc/ssh/sshd_config
RUN sed -i 's/UsePrivilegeSeparation sandbox/UsePrivilegeSeparation no/' /etc/ssh/sshd_config


# Download library for fake libcap calls
#RUN curl http://maci.satgnu.net/fakecap.so > /fakecap.so

# Build library for fake libcap calls
ADD fakecap.c /tmp/fakecap.c
RUN yum -y install gcc libcap-ng-devel
RUN gcc -Wall -pedantic -shared -fPIC /tmp/fakecap.c -o /fakecap.so
RUN yum -y remove gcc libcap-ng-devel cpp glibc-devel \
    glibc-headers kernel-headers libmpc mpfr 
RUN yum clean all


RUN systemctl mask dev-mqueue.mount dev-hugepages.mount \
    systemd-remount-fs.service sys-kernel-config.mount \
    sys-kernel-debug.mount sys-fs-fuse-connections.mount
RUN systemctl mask display-manager.service 
RUN systemctl disable graphical.target; systemctl enable multi-user.target

# Remove OOMScoreAdjust from dbus.service and set LD_PRELOAD
RUN sed 's/OOMScoreAdjust=-900/Environment="LD_PRELOAD=\/fakecap.so"/' \
 /usr/lib/systemd/system/dbus.service > /etc/systemd/system/dbus.service

VOLUME ["/sys/fs/cgroup"]
VOLUME ["/run"]

CMD  ["/usr/lib/systemd/systemd"]
