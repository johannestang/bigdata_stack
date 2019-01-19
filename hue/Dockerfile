# Note: This Dockerfile is based on https://github.com/cloudera/hue/blob/master/tools/docker/hue-base/Dockerfile
# The following changes have been made:
#
# 1. Dockerfile now based on specific Hue version.
# 2. Presto JDBC driver added.
# 3. Small quick-fix to JDBC interface to handle incompatibility with Presto.

FROM ubuntu:trusty
MAINTAINER johs@johs.me

ENV PRESTO_VERSION=0.215
ENV HUE_VERSION=4.3.0

RUN apt-get update -y

RUN apt-get install -y software-properties-common
RUN add-apt-repository -y ppa:webupd8team/java
RUN apt-get update -y

RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
RUN apt-get install -y oracle-java8-installer

RUN apt-get update -y
RUN apt-get install --fix-missing -q -y \
  git \
  ant \
  gcc \
  g++ \
  libkrb5-dev \
  libmysqlclient-dev \
  libssl-dev \
  libsasl2-dev \
  libsasl2-modules-gssapi-mit \
  libsqlite3-dev \
  libtidy-0.99-0 \
  libxml2-dev \
  libxslt-dev \
  libffi-dev \
  make \
  maven \
  libldap2-dev \
  python-dev \
  python-setuptools \
  libgmp3-dev \
  libz-dev \
  curl \
  postgresql-server-dev-all

RUN curl -L https://github.com/cloudera/hue/archive/release-${HUE_VERSION}.tar.gz -o /tmp/hue.tgz && \
    tar -xzf /tmp/hue.tgz -C / && \
    mv /hue-release-${HUE_VERSION} /hue && \
    rm -f /tmp/hue.tgz

RUN curl -L https://repo1.maven.org/maven2/com/facebook/presto/presto-jdbc/${PRESTO_VERSION}/presto-jdbc-${PRESTO_VERSION}.jar -o /usr/lib/jvm/java-8-oracle/jre/lib/ext/presto-jdbc.jar

COPY jdbc.py.diff /hue/desktop/libs/notebook/src/notebook/connectors/jdbc.py.diff
RUN cd /hue/desktop/libs/notebook/src/notebook/connectors && \
    patch < jdbc.py.diff

WORKDIR hue
RUN make apps

RUN /bin/bash -c "source ./build/env/bin/activate && pip install psycopg2-binary && deactivate"

EXPOSE 8888
VOLUME /hue/desktop/
CMD ["build/env/bin/hue", "runserver_plus", "0.0.0.0:8888"]
