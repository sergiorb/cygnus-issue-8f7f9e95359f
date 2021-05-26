#!/bin/bash

source data/data.sh

service=$1
path=$2
entityId=$3
attrName=$4

docker-compose -p $project_name exec -T mongodb mongo --eval "db.getCollection('sth_$path.aggr').find({'_id.range': 'hour', '_id.resolution':'minute', '_id.entityId':'$entityId', '_id.attrName':'$attrName'}).pretty();" sth_$service
