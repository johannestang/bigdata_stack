# Note: This Dockerfile is based on https://hub.docker.com/r/bde2020/hadoop-namenode
# The following changes have been made:
#
# 1. Hadoop updated to 2.8.5

FROM johannestang/hadoop-base:2.0.0-hadoop2.8.5-java8
MAINTAINER johs@johs.me

HEALTHCHECK CMD curl -f http://localhost:50070/ || exit 1

ENV HDFS_CONF_dfs_namenode_name_dir=file:///hadoop/dfs/name
RUN mkdir -p /hadoop/dfs/name
VOLUME /hadoop/dfs/name

ADD run.sh /run.sh
RUN chmod a+x /run.sh

EXPOSE 50070

CMD ["/run.sh"]
