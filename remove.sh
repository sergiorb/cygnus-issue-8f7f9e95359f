#!/bin/bash

echo "Stopping..."

source data/data.sh

docker-compose -p "$project_name" down

./cleanup.sh
