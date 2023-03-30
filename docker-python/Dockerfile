FROM centos-sssd:7.8.2003
LABEL "version"="1.9"

USER root
ENV PATH=/opt/python-3.7.7/bin:/usr/bin:/usr/sbin:/opt/mssql-tools/bin ORACLE_HOME=/oracle TNS_ADMIN=/oracle/network/admin OCI_LIB=/oracle/instantclient_12_1 LD_LIBRARY_PATH=/oracle/instantclient_12_1:/exasol/EXASolution_ODBC-7.1.2/lib/linux/x86_64:$LD_LIBRARY_PATH ACCEPT_EULA=Y
WORKDIR /tmp

RUN curl -s -o /etc/yum.repos.d/confluence.repo http://ds-build-server.lat.internal/confluence.repo && \
    curl -s -o /etc/yum.repos.d/mssql-release.repo https://packages.microsoft.com/config/rhel/7/prod.repo && \
    curl -s -o Python-3.7.7.tgz http://ds-build-server.lat.internal/Python-3.7.7.tgz && \
    curl -s -o ClouderaHiveODBC-2.6.1.1001-1.x86_64.rpm http://ds-build-server.lat.internal/ClouderaHiveODBC-2.6.1.1001-1.x86_64.rpm && \
    curl -s -o instantclient-basic-linux.x64-12.1.0.2.0.zip http://ds-build-server.lat.internal/instantclient-basic-linux.x64-12.1.0.2.0.zip && \
    curl -s -o instantclient-sdk-linux.x64-12.1.0.2.0.zip http://ds-build-server.lat.internal/instantclient-sdk-linux.x64-12.1.0.2.0.zip && \
    curl -s -o EXASOL_ODBC-7.1.2.tar http://ds-build-server.lat.internal/EXASOL_ODBC-7.1.2.tar && \
    rpm --import https://packages.confluent.io/rpm/6.0/archive.key && \
    yum -y update && \
    yum -y groupinstall "Development tools" && \
    yum -y install \
      msodbcsql17 \
      mssql-tools \
      krb5-workstation \
      librdkafka-devel \
      libffi-devel \
      bzip2-devel \
      readline-devel \
      zlib-devel \
      ncurses-devel \
      sqlite-devel \
      tk-devel \
      uuid-devel \
      xz-devel \
      gdbm-devel \
      tar \
      gzip \
      unzip \
      libxml2-devel \
      unixODBC-devel \
      libcurl-devel \
      openssl-devel \
      libssh2-devel \
      cyrus-sasl-devel \
      libaio \
      cairo-devel \
      gsl-devel \
      mailx \
      cyrus-sasl-gssapi \
      java-1.8.0-openjdk \
      ClouderaHiveODBC-2.6.1.1001-1.x86_64.rpm && \
      tar -zxf Python-3.7.7.tgz && \
      cd Python-3.7.7 && \
      ./configure --prefix=/opt/python-3.7.7 --disable-ipv6 && \
      make && \
      make install && \
      cd .. && \
      mkdir -p /oracle/rdbms && \
      mkdir -p /oracle/network/admin && \
      mkdir /exasol && \
      unzip instantclient-basic-linux.x64-12.1.0.2.0.zip -d /oracle && \
      unzip instantclient-sdk-linux.x64-12.1.0.2.0.zip -d /oracle &&  \
      tar -C /exasol -xf EXASOL_ODBC-7.1.2.tar && \
      ln -s /oracle/instantclient_12_1/sdk/include /oracle/rdbms/public && \
      ln -s /oracle/instantclient_12_1/libclntsh.so.12.1 /oracle/instantclient_12_1/libclntsh.so && \
      rm -rf * && \
      yum -y clean all && \
      touch /oracle/network/admin/tnsnames.ora && \
      touch /etc/odbc.ini && \
      touch /etc/odbcinst.ini && \
      touch /opt/cloudera/hiveodbc/lib/64/cloudera.hiveodbc.ini
RUN /opt/python-3.7.7/bin/python3 -m pip install --upgrade pip && \
    pip install \
      cx-Oracle \
      pyexasol \
      pandas \
      wheel \
      seaborn \
      matplotlib \
      nbconvert \
      pyhive \
      scikit-learn \
      requests \
      tableauserverclient \
      pypyodbc \
      plotly \
      statsmodels \
      bokeh \
      pyodbc \
      NLTK \
      SQLAlchemy \
      websocket-client \
      pyspark && \
      ln -s /opt/python-3.7.7/bin/python3 /opt/python-3.7.7/bin/python
