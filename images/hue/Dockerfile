# Note: This Dockerfile is based on https://github.com/cloudera/hue/blob/master/tools/docker/hue/Dockerfile
# The following changes have been made:
#
# 1. Dockerfile now based on specific Hue version.
# 2. Presto JDBC driver added.

FROM ubuntu:18.04
MAINTAINER johs@johs.me

ENV PRESTO_VERSION=326
ENV HUE_VERSION=4.5.0

RUN apt-get update -y && apt-get install -y \
  build-essential \
  libkrb5-dev \
  libmysqlclient-dev \
  libssl-dev \
  libsasl2-dev \
  libsasl2-modules-gssapi-mit \
  libsqlite3-dev \
  libtidy-dev \
  libxml2-dev \
  libxslt-dev \
  libffi-dev \
  libldap2-dev \
  libpq-dev \
  python-dev \
  python-setuptools \
  libgmp3-dev \
  libz-dev \
  software-properties-common \
  curl \
  git \
  rsync \
  sudo \
  maven \
  gcc \
  swig \
  # openssl \ # Breaks build
  xmlsec1 \
  libxmlsec1-openssl \
  && rm -rf /var/lib/apt/lists/*

# Get Hue from Git repo
WORKDIR /
RUN git clone -n https://github.com/cloudera/hue
WORKDIR /hue
RUN git checkout release-${HUE_VERSION}

# Install Presto JDBC driver
RUN mkdir -p /opt/presto
RUN curl -L https://repo1.maven.org/maven2/io/prestosql/presto-jdbc/${PRESTO_VERSION}/presto-jdbc-${PRESTO_VERSION}.jar \
         -o /opt/presto/presto-jdbc.jar

# Not doing a `make prod`, so manually getting production ini
RUN rm desktop/conf/*
RUN cp desktop/conf.dist/* desktop/conf

# Need recent version for Ubuntu
RUN curl -sL https://deb.nodesource.com/setup_10.x | sudo bash - \
  && apt-get install -y nodejs

RUN PREFIX=/usr/share make install
RUN useradd -ms /bin/bash hue && chown -R hue /usr/share/hue

# Only keep install dir
# Note: get more minimal image by pulling install dir in a stage 2 image
WORKDIR /usr/share/hue
RUN rm -rf /hue \
  && rm -rf node_modules

# Install DB connectors
RUN ./build/env/bin/pip install \
  psycopg2-binary \
  redis==2.10.6 \
  django_redis \
  flower \
  gevent \
  threadloop # Needed for Jaeger

COPY conf desktop/conf
COPY startup.sh .

EXPOSE 8888
CMD ["./startup.sh"]
