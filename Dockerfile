# Openresty + OpenSSL 
#
# OpenResty VERSION       1.11.2.1
# OpenSSL Version         1.0.2k

# use the kong:0.10.0 base image provided by Mashape
FROM kong:0.10.0
MAINTAINER Vladimir Murray, vladimir.murray@oneflow.io

# Dependencies versions
ENV OPENRESTY_VERSION 1.11.2.1
ENV OPENSSL_VERSION 1.0.2k
ENV DOWNLOAD_CACHE /tmp/download-cache
ENV INSTALL_CACHE $HOME/install-cache

ENV OPENSSL_DOWNLOAD $DOWNLOAD_CACHE/openssl-$OPENSSL_VERSION
ENV OPENRESTY_DOWNLOAD $DOWNLOAD_CACHE/openresty-$OPENRESTY_VERSION

# make download folders
RUN mkdir -p $OPENSSL_DOWNLOAD $OPENRESTY_DOWNLOAD

# make sure the system is up to date
RUN yum -y upgrade

# install dependencies required to compile and build OpenResty
RUN yum -y install wget tar perl gcc-c++ readline-devel pcre-devel openssl-devel git make unzip python-pip

# download openssl
RUN cd $DOWNLOAD_CACHE && wget http://www.openssl.org/source/openssl-$OPENSSL_VERSION.tar.gz | tar xzf openssl-$OPENSSL_VERSION.tar.gz

# download OpenResty
RUN cd $DOWNLOAD_CACHE && wget https://openresty.org/download/openresty-$OPENRESTY_VERSION.tar.gz | tar xzf openresty-$OPENRESTY_VERSION.tar.gz

# adding installation folder
ENV OPENSSL_INSTALL $INSTALL_CACHE/openssl-$OPENSSL_VERSION
ENV OPENRESTY_INSTALL $INSTALL_CACHE/openresty-$OPENRESTY_VERSION

RUN mkdir -p $OPENSSL_INSTALL $OPENRESTY_INSTALL

# configure, build and install OpenSSL
RUN cd $OPENSSL_DOWNLOAD && ./config shared --prefix=$OPENSSL_INSTALL  && make && make install

# configure, build and install OpenResty
RUN cd $OPENRESTY_DOWNLOAD && ./configure --prefix=$OPENRESTY_INSTALL --with-openssl=$OPENSSL_DOWNLOAD --with-http_ssl_module --with-http_stub_status_module --with-luajit --with-http_realip_module --with-pcre-jit --with-ipv6  && make && make install

#adding openssl to ENV
ENV OPENSSL_DIR $OPENSSL_INSTALL

# adding OpenResty to the PATH 
ENV PATH $PATH:$OPENRESTY_INSTALL/nginx/sbin:$OPENRESTY_INSTALL/bin