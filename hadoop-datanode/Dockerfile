# Note: This Dockerfile is based on https://hub.docker.com/r/bde2020/hadoop-datanode
# The following changes have been made:
#
# 1. Hadoop updated to 2.8.5

FROM johannestang/hadoop-base:2.0.0-hadoop2.8.5-java8
MAINTAINER johs@johs.me

HEALTHCHECK CMD curl -f http://localhost:50075/ || exit 1

ENV HDFS_CONF_dfs_datanode_data_dir=file:///hadoop/dfs/data
RUN mkdir -p /hadoop/dfs/data
VOLUME /hadoop/dfs/data

ADD run.sh /run.sh
RUN chmod a+x /run.sh

EXPOSE 50075

CMD ["/run.sh"]
