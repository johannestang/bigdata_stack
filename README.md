# Big Data Stack

Big data stack running in pseudo-distributed mode with the following components:

 - Hadoop
 - Minio
 - Hive
 - Presto
 - Superset
 - Hue

## Quick start

Clone the repository and create `.env` file based on `sample.env` making sure `DATADIR` points to a 
suitable directory (persistent storage for all containers). Bring up the stack:
```
docker-compose up -d
```

