# cygnus-issue-8f7f9e95359f

Cygnus seems to be mixing data from differents devices when generates aggregates through STH_Commet sink.

- `data_model = dm-by-service-path`

# Requirements
- bash
- docker
- docker-compose
- python3

# Usage

Execute `$ ./start.sh` to watch the issue.

You can also use:
- `$ ./remove.sh` to stop and remove the containers and volumes (be careful if you have volumes named after `cygnus-issue-8f7f9e95359f` )
- `$ ./setup.sh` to setup containers after running manual `docker-compose up`.
- `$ ./run.sh` to execute the issue secction.
- `$ ./check_aggr.sh example /759cd022bd7d11ebad875b8db9cda43b foo_000 co2` to check aggregates generation.

# Queries:
- device foo_000: `db.getCollection('sth_/759cd022bd7d11ebad875b8db9cda43b.aggr').find({'_id.range': 'hour', '_id.resolution':'minute', '_id.entityId':'foo_000', '_id.attrName':'co2'}).pretty()`
- device foo_001: `db.getCollection('sth_/759cd022bd7d11ebad875b8db9cda43b.aggr').find({'_id.range': 'hour', '_id.resolution':'minute', '_id.entityId':'foo_001', '_id.attrName':'co2'}).pretty()`
