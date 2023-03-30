FROM centos:8.4.2105
LABEL "description"="centos 8.4 with sssd"
LABEL "version"="8.4.2105"
USER root
COPY system.repo /etc/yum.repos.d/
RUN rm -f /etc/yum.repos.d/C* && \
#    yum -y update && \
    yum -y install sssd && \
    yum -y clean all && \
    touch /etc/sssd/sssd.conf /etc/pam.d/allowed-groups /etc/ssl/certs/ldap-ca.crt && \
    chmod 600 /etc/sssd/sssd.conf
ENV PATH=/bin:/sbin:/usr/bin:/usr/sbin \
    LANG=en_US.UTF-8

