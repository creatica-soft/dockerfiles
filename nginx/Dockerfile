FROM centos-sssd:7.8.2003 as build
WORKDIR /tmp
ADD http://build.example.com/nginx-auth-ldap.tar.gz /tmp/
ADD http://build.example.com/nginx-1.19.5.tar.gz /tmp/
RUN yum -y update && \
    yum -y groupinstall "Development Tools" && \
    yum -y install \
      openssl-devel \
      openldap-devel 
RUN tar -xf nginx-1.19.5.tar.gz && \
    tar -xf nginx-auth-ldap.tar.gz && \
    cd nginx-1.19.5 && \
    ./configure --prefix=/opt/nginx --with-http_ssl_module --add-module=../nginx-auth-ldap && \
    make && \
    make install


FROM centos:7.8.2003
LABEL "version"="1.19.5"
LABEL "description"="nginx with PAM authentication module"
COPY system.repo /etc/yum.repos.d/
RUN rm -rf /etc/yum.repos.d/C* && \
    yum -y update && \
    yum -y install \
      openldap \
      openssl && \
    groupadd --system --gid 101 nginx && useradd --system --gid nginx --no-create-home --home-dir /nonexistent --comment "nginx user" --shell /sbin/nologin --uid 101 nginx
COPY --from=build /opt/nginx /opt/nginx/
CMD ln -sf /proc/self/fd /dev/ && /opt/nginx/sbin/nginx -g "daemon off;"

