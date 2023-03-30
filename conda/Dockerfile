FROM jupyter/minimal-notebook
LABEL "version"="1.9"
LABEL "description"="The open-source Anaconda Distribution is the easiest way to perform Python/R data science and machine learning on Linux, Windows, and Mac OS X - https://www.anaconda.com/"

USER root
ENV ACCEPT_EULA=Y
WORKDIR /tmp
RUN apt-get update && \
    apt-get install -y --no-install-recommends gnupg apt-utils && \
    wget -qO - https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
#    wget -qO - https://packages.confluent.io/deb/6.2/archive.key | apt-key add - && \
    wget https://packages.microsoft.com/config/ubuntu/20.04/prod.list && \
    mv prod.list /etc/apt/sources.list.d/mssql-release.list && \
#    echo "deb https://packages.confluent.io/deb/6.2 stable main" >> /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends rpm \
       build-essential \
       zlib1g-dev \
       libssl-dev \
       libsasl2-dev \
       libzstd-dev \
       libpthread-stubs0-dev \
       ffmpeg \
       libaio1 \
       libaio-dev \
       unixodbc \
       unixodbc-dev \
       libsasl2-dev \
       libsasl2-modules-gssapi-mit \
       openjdk-8-jdk \
       msodbcsql17 \
       mssql-tools \
       htop \
       curl \
       iputils-ping \
       tree \
       krb5-user \
       krb5-config && \
#       librdkafka-dev \
#       python3-confluent-kafka && \
    wget https://github.com/edenhill/librdkafka/archive/refs/tags/v1.7.0.tar.gz && \
    tar -zxf v1.7.0.tar.gz && \
    cd librdkafka-1.7.0 && \
    ./configure --prefix=/usr --sysconfdir=/etc --localstatedir=/var --runstatedir=/var/run --install-deps && \
    make && \
    make install && \
    cd /tmp && \
    rm -rf librdkafka-1.7.0 && \
    rm -f v1.7.0.tar.gz && \
    wget -q http://ds-build-server.lat.internal/clouderahiveodbc_2.6.4.1004-2_amd64.deb && \
    wget -q http://ds-build-server.lat.internal/instantclient-basic-linux.x64-12.1.0.2.0.zip && \
    wget -q http://ds-build-server.lat.internal/instantclient-sdk-linux.x64-12.1.0.2.0.zip && \
    wget -q http://ds-build-server.lat.internal/EXASOL_ODBC-7.1.2.tar && \
    apt install -y /tmp/clouderahiveodbc_2.6.4.1004-2_amd64.deb && \
    mkdir /oracle && \
    mkdir /exasol && \
    unzip instantclient-basic-linux.x64-12.1.0.2.0.zip -d /oracle && \
    unzip instantclient-sdk-linux.x64-12.1.0.2.0.zip -d /oracle && \
    mkdir -p /oracle/network/admin && \
    rm -f instantclient-basic-linux.x64-12.1.0.2.0.zip && \
    rm -f instantclient-sdk-linux.x64-12.1.0.2.0.zip && \
    mkdir /oracle/rdbms && \
    ln -s /oracle/instantclient_12_1/sdk/include /oracle/rdbms/public && \
    ln -s /oracle/instantclient_12_1/libclntsh.so.12.1 /oracle/instantclient_12_1/libclntsh.so && \
    tar -C /exasol -xf /tmp/EXASOL_ODBC-7.1.2.tar && \
    rm EXASOL_ODBC-7.1.2.tar && \
    rm -f /tmp/clouderahiveodbc_2.6.4.1004-2_amd64.deb && \
    touch /opt/cloudera/hiveodbc/Setup/odbc.ini && \
    touch /oracle/network/admin/tnsnames.ora && \
    mkdir -p /etc/kerberos && \
    rm -rf /tmp/* && \
    rm -f /home/jovyan/.wget-hsts && \
    rm -rf /var/lib/apt/lists/*

ENV ORACLE_HOME=/oracle TNS_ADMIN=/oracle/network/admin OCI_LIB=/oracle/instantclient_12_1 LD_LIBRARY_PATH=/oracle/instantclient_12_1:/exasol/EXASOL_ODBC-7.1.2/lib/linux/x86_64 ODBCSYSINI=/opt/cloudera/hiveodbc/Setup
VOLUME /home /etc/kerberos/config /etc/kerberos/keytabs

USER $NB_UID

# Install Python 3 packages

RUN mkdir /tmp/pip && \
    mkdir /tmp/build && \
    TMPDIR=/tmp/pip python -m pip install --no-cache-dir --build=/tmp/build --upgrade pip \
      scipy \
      scikit-learn \
      matplotlib \
      seaborn \
      pyspark \
      pyhive \
      dask \
      more-itertools \
      requests \
      cx-Oracle \
      pyexasol \
      jupyter-helpers \
      tableauserverclient \
      pypyodbc \
      plotly \
      pyodbc \
      confluent-kafka \
      NLTK && \
    rm -rf /tmp/pip && \
    rm -rf /tmp/build

# Import matplotlib the first time to build the font cache.
ENV XDG_CACHE_HOME /home/$NB_USER/.cache/
RUN MPLBACKEND=Agg python -c "import matplotlib.pyplot" && \
    fix-permissions /home/$NB_USER
WORKDIR $HOME

