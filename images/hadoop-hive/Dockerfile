# Note: This Dockerfile is based on https://hub.docker.com/r/bde2020/hadoop-base
# The following changes have been made:
#
# 1. Hadoop updated to 2.8.5
# 2. Hive updated to 2.3.6
# 3. AWS S3 jars added

FROM johannestang/hadoop-base:2.0.0-hadoop2.8.5-java8

MAINTAINER johs@johs.me

ENV HADOOP_VERSION 2.8.5
ENV HIVE_VERSION 2.3.6
ENV AWS_VERSION=1.10.75.2

ENV HIVE_HOME /opt/hive
ENV PATH $HIVE_HOME/bin:$PATH
ENV HADOOP_HOME /opt/hadoop-$HADOOP_VERSION

WORKDIR /opt

#Install Hive and PostgreSQL JDBC
RUN apt-get update && apt-get install -y wget procps && \
	wget https://archive.apache.org/dist/hive/hive-$HIVE_VERSION/apache-hive-$HIVE_VERSION-bin.tar.gz && \
	tar -xzvf apache-hive-$HIVE_VERSION-bin.tar.gz && \
	mv apache-hive-$HIVE_VERSION-bin hive && \
	wget https://jdbc.postgresql.org/download/postgresql-9.4.1212.jar -O $HIVE_HOME/lib/postgresql-jdbc.jar && \
	rm apache-hive-$HIVE_VERSION-bin.tar.gz && \
	apt-get --purge remove -y wget && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*


#Spark should be compiled with Hive to be able to use it
#hive-site.xml should be copied to $SPARK_HOME/conf folder

#Custom configuration goes here
ADD conf/hive-site.xml $HIVE_HOME/conf
ADD conf/beeline-log4j2.properties $HIVE_HOME/conf
ADD conf/hive-env.sh $HIVE_HOME/conf
ADD conf/hive-exec-log4j2.properties $HIVE_HOME/conf
ADD conf/hive-log4j2.properties $HIVE_HOME/conf
ADD conf/ivysettings.xml $HIVE_HOME/conf
ADD conf/llap-daemon-log4j2.properties $HIVE_HOME/conf

COPY startup.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/startup.sh

COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh

RUN curl -L http://central.maven.org/maven2/com/amazonaws/aws-java-sdk/${AWS_VERSION}/aws-java-sdk-${AWS_VERSION}.jar -o /opt/hive/lib/aws-java-sdk.jar && \
    curl -L http://central.maven.org/maven2/com/amazonaws/aws-java-sdk-core/${AWS_VERSION}/aws-java-sdk-core-${AWS_VERSION}.jar -o /opt/hive/lib/aws-java-sdk-core.jar && \
    curl -L http://central.maven.org/maven2/com/amazonaws/aws-java-sdk-s3/${AWS_VERSION}/aws-java-sdk-s3-${AWS_VERSION}.jar -o /opt/hive/lib/aws-java-sdk-s3.jar && \
    curl -L http://central.maven.org/maven2/org/apache/hadoop/hadoop-aws/${HADOOP_VERSION}/hadoop-aws-${HADOOP_VERSION}.jar -o /opt/hive/lib/hadoop-aws.jar

EXPOSE 10000
EXPOSE 10002

ENTRYPOINT ["entrypoint.sh"]
CMD startup.sh
