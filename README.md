# Big Data Stack

Big data stack running in pseudo-distributed mode with the following components:

 - Hadoop 2.8.5
 - Minio RELEASE.2019-10-12T01-39-57Z
 - Hive 2.3.6
 - Presto 326
 - Superset 0.35.1
 - Hue 4.5.0

For more details see the following [post](https://johs.me/posts/big-data-stack-running-sql-queries/).

## Quick start

Clone the repository and create `.env` file based on `sample.env` making sure `DATADIR` points to a 
suitable directory (persistent storage for all containers). Bring up the base stack:
```
docker-compose up -d
```
If you also want to start Superset and Hue, then run:
```
docker-compose -f superset/docker-compose.yml up -d
docker-compose -f hue/docker-compose.yml up -d
```
and initialize:
```
./scripts/init-hue.sh
./scripts/init-superset.sh
```
The stack should now be up and running and the following services available:

 - Hadoop namenode: [http://localhost:50070](http://localhost:50070)
 - Minio: [http://localhost:9000](http://localhost:9000)
 - Presto: [http://localhost:8080](http://localhost:8080)
 - Superset: [http://localhost:8088](http://localhost:8088)
 - Hue: [http://localhost:8888](http://localhost:8888)

## Contents

The stack uses update/modified Docker images from [Big Data Europe](https://github.com/big-data-europe),
 [shawnzhu](https://github.com/shawnzhu/docker-prestodb), and [Cloudera](https://github.com/cloudera/hue). See
Dockerfiles for details.

All needed images are on Docker Hub, but if you want to build the updated/modified images yourself, just run `build-local.sh`
in the different sub-directories.

Changes compared to original images:

 - Hadoop updated to version 2.8.5
 - Hive update to version 2.3.6
 - S3 support added
 - Presto update to 326
 - Presto JDBC driver added to Hue

The scripts directory contains some helper scripts:

 - `beeline.sh`: Launch Beeline (Hive CLI) in Hive container 
 - `hadoop-client.sh`: Start container with Hadoop utilities (host filesystem mounted as `/host`). Useful for moving files to HDFS.
 - `init-hue.sh`: Create admin home folder in HDFS in order to avoid error in Hue File Browser.
 - `init-superset.sh`: Initialize Superset database and add Presto as data source
 - `presto-cli.sh`: Launch Presto CLI (downloads jar if needed)

