FROM centos-sssd:7.8.2003
LABEL "description"="A language for data analysis and graphics - http://www.r-project.org"
LABEL "version"="3.6.0"
RUN yum -y update && \
    yum -y install wget && \
    cd /tmp && \
    wget http://build.example.com/instantclient-basic-linux.x64-12.1.0.2.0.zip && \
    wget http://build.example.com/instantclient-sdk-linux.x64-12.1.0.2.0.zip && \
    wget http://build.example.com/ClouderaHiveODBC-2.6.1.1001-1.x86_64.rpm && \
    wget http://build.example.com/EXASOL_ODBC-7.1.2.tar.gz && \
    wget http://build.example.com/capt-of.zip && \
    wget http://build.example.com/needspace.zip && \
    wget http://build.example.com/tabulary.zip && \
    wget http://build.example.com/upquote.zip && \
    yum -y install /tmp/ClouderaHiveODBC-2.6.1.1001-1.x86_64.rpm \
      cairo-devel \
      gdal-devel \
      gsl-devel \
      gzip \
      libaio \
      libcurl-devel \
      libgit2-devel \
      libssh2-devel \
      libxml2-devel \
      mailx \
      openssl-devel \
      R \
      readline-devel \
      tar \
      texlive-* \
      unixODBC-devel \
      unzip \
      v8-devel && \
    yum -y clean all && \
    rm -f /tmp/ClouderaHiveODBC-2.6.1.1001-1.x86_64.rpm && \
    mkdir /oracle && \
    mkdir /exasol && \
    unzip /tmp/instantclient-basic-linux.x64-12.1.0.2.0.zip -d /oracle && \
    unzip /tmp/instantclient-sdk-linux.x64-12.1.0.2.0.zip -d /oracle && \
    mkdir -p /oracle/network/admin && \
    rm /tmp/instantclient-basic-linux.x64-12.1.0.2.0.zip && \
    rm /tmp/instantclient-sdk-linux.x64-12.1.0.2.0.zip && \
    mkdir /oracle/rdbms &&  \
    ln -s /oracle/instantclient_12_1/sdk/include /oracle/rdbms/public && \
    ln -s /oracle/instantclient_12_1/libclntsh.so.12.1 /oracle/instantclient_12_1/libclntsh.so && \
    touch /oracle/network/admin/tnsnames.ora && \
    tar -C /exasol -xzf /tmp/EXASOL_ODBC-7.1.2.tar.gz && \
    rm /tmp/EXASOL_ODBC-7.1.2.tar.gz && \
    touch /etc/odbc.ini && \
    touch /etc/odbcinst.ini && \
    touch /usr/lib64/R/etc/Renviron.site && \
    touch /usr/lib64/R/.Rprofile.site && \
    cd /usr/share/texlive/texmf/tex/latex && \
    unzip /tmp/capt-of.zip && \
    unzip /tmp/needspace.zip && \
    unzip /tmp/tabulary.zip && \
    unzip /tmp/upquote.zip && \
    cd capt-of && \
    latex capt-of.ins && \
    latex capt-of.dtx && \
    mv capt-of.dvi ../../../doc && \
    mv capt-of.pdf ../../../doc && \
    cd ../needspace && \
    latex needspace.ins && \
    mv needspace.pdf ../../../doc && \
    cd ../tabulary && \
    latex tabulary.ins && \
    latex tabulary.dtx && \
    makeindex -s gglo.ist -o tabulary.gls tabulary.glo && \
    mv tabulary.pdf ../../../doc && \
    mv tabulary.dvi ../../../doc && \
    mv ../upquote/upquote.pdf ../../../doc && \
    texhash && \
    rm -f /tmp/*.zip
ENV PATH=/usr/lib64/R/bin:/usr/lib64/R/lib64/R/bin:/usr/bin:/usr/sbin ORACLE_HOME=/oracle TNS_ADMIN=/oracle/network/admin OCI_LIB=/oracle/instantclient_12_1 LD_LIBRARY_PATH=/oracle/instantclient_12_1:/exasol/EXASOL_ODBC-7.1.2/lib/linux/x86_64:/opt/quest/lib64/nss:/usr/lib64/security LANG=en_US.UTF-8
RUN R -e "update.packages(repos='https://repo-r.example.com/repository/r-proxy-cran', ask = FALSE)" 
RUN R -e "install.packages('devtools', repos='https://repo-r.example.com/repository/r-proxy-cran', clean = TRUE)"
RUN R -e "install.packages('ROracle', repos='https://repo-r.example.com/repository/r-proxy-cran', clean = TRUE)"
RUN R -e "install.packages('mailR', repos='https://repo-r.example.com/repository/r-proxy-cran', clean = TRUE)"
RUN R -e "install.packages('tidyverse', repos='https://repo-r.example.com/repository/r-proxy-cran', clean = TRUE)"
RUN R -e "install.packages('sparklyr', repos='https://repo-r.example.com/repository/r-proxy-cran', clean = TRUE)"
RUN R -e "install.packages('forecast', repos='https://repo-r.example.com/repository/r-proxy-cran', clean = TRUE)"
RUN R -e "install.packages('matrixStats', repos='https://repo-r.example.com/repository/r-proxy-cran', clean = TRUE)"
RUN R -e "install.packages('plotly', repos='https://repo-r.example.com/repository/r-proxy-cran', clean = TRUE)"
RUN R -e "install.packages('qcc', repos='https://repo-r.example.com/repository/r-proxy-cran', clean = TRUE)"
RUN R -e "install.packages('XLConnect', repos='https://repo-r.example.com/repository/r-proxy-cran', clean = TRUE)"
RUN R -e "install.packages('logging', repos='https://repo-r.example.com/repository/r-proxy-cran', clean = TRUE)"
RUN R -e "install.packages('XML', repos='https://repo-r.example.com/repository/r-proxy-cran', clean = TRUE)"
RUN R -e "install.packages('RSQLite',  repos='https://repo-r.example.com/repository/r-proxy-cran', clean = TRUE)"
#RUN R -e "install.packages('DBI', repos='https://repo-r.example.com/repository/r-proxy-cran', clean = TRUE)"
RUN R -e "install.packages('http://ds-build-server.lat.internal/DBI_0.3.1.tar.gz', repos=NULL, clean = TRUE, lock = FALSE)"
RUN R -e "install.packages('RODBC', repos='https://repo-r.example.com/repository/r-proxy-cran', clean = TRUE)"
#RUN R -e "install.packages('http://build.example.com/RODBC_1.3-16.tar.gz', repos=NULL, clean = TRUE, lock = FALSE)"
RUN R -e "install.packages('assertthat', repos='https://repo-r.example.com/repository/r-proxy-cran', clean = TRUE)"
#RUN R -e "install.packages('http://build.example.com/assertthat_0.1.tar.gz', repos=NULL, clean = TRUE, lock = FALSE)"
RUN R -e "devtools::install_github('exasol/r-exasol')"


