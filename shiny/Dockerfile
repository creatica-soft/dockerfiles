FROM r:3.5.2-2.el7
LABEL "version"="1.5.9.923"
LABEL "description"="Shiny server"
RUN mkdir -p /usr/share/doc/R-3.5.2/html
RUN R -e "install.packages(c('shiny','rmarkdown'), repos='https://repo-r.example.com.com/repository/r-proxy-cran')"
COPY shiny-server-1.5.9.923-x86_64.rpm /tmp
RUN yum -y install /tmp/shiny-server-1.5.9.923-x86_64.rpm && rm /tmp/shiny-server-1.5.9.923-x86_64.rpm
VOLUME /home
ENV ORACLE_HOME=/oracle TNS_ADMIN=/oracle/network/admin OCI_LIB=/oracle/instantclient_12_1 LD_LIBRARY_PATH=/oracle/instantclient_12_1:/exasol/EXASOL_ODBC-7.1.2/lib/linux/x86_64:/usr/lib64/security:/opt/quest/lib64/nss ODBCINI=/exasol/.odbc.ini
CMD /opt/shiny-server/ext/node/bin/shiny-server /opt/shiny-server/lib/main.js
