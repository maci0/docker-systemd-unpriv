FROM centos:centos7
MAINTAINER Marcel Wysocki "maci.stgn@gmail.com"
ENV container docker

RUN yum -y update; yum clean all

RUN systemctl mask dev-mqueue.mount dev-hugepages.mount \
    systemd-remount-fs.service sys-kernel-config.mount \
    sys-kernel-debug.mount sys-fs-fuse-connections.mount
RUN systemctl mask display-manager.service 
RUN systemctl disable graphical.target; systemctl enable multi-user.target

ADD dbus.service /etc/systemd/system/dbus.service

RUN yum -y install passwd openssh-server; yum clean all
RUN echo root | passwd --stdin root
RUN echo "UseDNS no" >> /etc/ssh/sshd_config
RUN sed -i 's/UsePrivilegeSeparation sandbox/UsePrivilegeSeparation no/' /etc/ssh/sshd_config

VOLUME ["/sys/fs/cgroup"]

CMD  ["/usr/lib/systemd/systemd"]
