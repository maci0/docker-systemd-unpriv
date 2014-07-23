FROM centos:centos7
MAINTAINER Marcel Wysocki "maci.stgn@gmail.com"
ENV container docker

RUN yum -y update
RUN yum -y install passwd openssh-server
RUN yum clean all
RUN echo root | passwd --stdin root
RUN echo "UseDNS no" >> /etc/ssh/sshd_config

# Download library for fake libcap calls
#RUN curl http://maci.satgnu.net/fakecap.so > /fakecap.so

# Build library for fake libcap calls
ADD fakecap.c /tmp/fakecap.c
RUN yum -y install gcc libcap-ng-devel
RUN gcc -Wall -pedantic -shared -fPIC /tmp/fakecap.c -o /fakecap.so
RUN yum -y remove gcc libcap-ng-devel cpp glibc-devel \
    glibc-headers kernel-headers libmpc mpfr 
RUN yum clean all


# Disable and mask all systemd units
RUN rm -Rf /etc/systemd/system/* 
RUN for UNIT in `find /usr/lib/systemd/system -type f -printf '%P\n'`; \
    do systemctl mask $UNIT;done

# Get rid of stupid warning
RUN systemctl mask display-manager.service

# Re-enable needed systemd units
RUN systemctl unmask multi-user.target basic.target sysinit.target \
          halt.target shutdown.target umount.target final.target \
          ctrl-alt-del.target getty.target dbus.service dbus.socket \
          systemd-logind.service systemd-journald.service \
          systemd-shutdownd.service systemd-shutdownd.socket \
          systemd-reboot.service systemd-halt.service \
          console-getty.service sshd.service network.target
RUN systemctl enable console-getty.service sshd.service

# Remove OOMScoreAdjust from dbus.service and set LD_PRELOAD
RUN sed 's/OOMScoreAdjust=-900/Environment="LD_PRELOAD=\/fakecap.so"/' \
 /usr/lib/systemd/system/dbus.service > /etc/systemd/system/dbus.service

CMD  ["/usr/lib/systemd/systemd"]
