FROM r:3.5.2-9
LABEL "description"="Rserve - http://www.rforge.net/Rserve"
LABEL "version"="1.7-3.1"
RUN rm -rf /etc/yum.repos.d/*
COPY system.repo /etc/yum.repos.d/
RUN yum -y update 
RUN yum -y clean all
RUN groupadd -g 1000 rserve && useradd -g rserve -d /home/rserve -m rserve && chown rserve:rserve /home/rserve
COPY --chown=rserve:rserve Rserv.conf passwd.rserver /etc/
ENV PATH=/usr/lib64/R/bin:/usr/lib64/R/lib64/R/bin:/usr/bin:/usr/sbin ORACLE_HOME=/oracle TNS_ADMIN=/oracle/network/admin OCI_LIB=/oracle/instantclient_12_1 LD_LIBRARY_PATH=/oracle/instantclient_12_1:/exasol/EXASOL_ODBC-7.1.2/lib/linux/x86_64:/opt/quest/lib64/nss:/usr/lib64/security LANG=en_US.UTF-8
RUN R -e "update.packages(repos='https://repo-r.example.com/repository/r-proxy-cran', ask = FALSE)" && R -e "install.packages(c('Rserve'),  repos='https://repo-r.example.com/repository/r-proxy-cran', clean = TRUE)"
COPY --chown=rserve:rserve rserve.R /home/rserve/
COPY rscript.sh /usr/bin/
RUN chmod 755 /usr/bin/rscript.sh
EXPOSE 6311
ENV R_HOME=/usr/lib64/R

USER rserve
CMD /usr/bin/rscript.sh
