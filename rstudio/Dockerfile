FROM r:4.1.2
LABEL "version"="2021.09.1-372"
LABEL "description"="RStudio Server"
RUN yum -y install \
      http://build.example.com/rstudio-server-rhel-2021.09.1-372-x86_64.rpm \
      git \
      traceroute \
      telnet \
      net-tools \
      htop && \
      yum -y clean all
RUN touch /etc/odbc.ini /etc/odbcinst.ini /etc/pam.d/rstudio
EXPOSE 8787
VOLUME /home
CMD sssd -d 0x003 --logger=stderr && /usr/lib/rstudio-server/bin/rserver --server-daemonize 0

