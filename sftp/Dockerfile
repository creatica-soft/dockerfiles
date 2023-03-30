FROM centos-sssd:7.8.2003-1
LABEL "description"="sshd with sftp subsystem"
LABEL "version"="2.0"
RUN yum install -y openssh-server && \
    ssh-keygen -A && \
    groupadd group && \
    useradd -g group -m -u 173923 user && \
    yum -y clean all
COPY shadow /etc/
RUN chmod 000 /etc/shadow
COPY sshd_config /etc/ssh/
EXPOSE 2222
VOLUME /data /public /shiny
CMD sssd -d 0x003 --logger=stderr && /usr/sbin/sshd -D -p 2222
