#!/bin/bash

source data/data.sh

echo -e "\e[35mStarting as\e[0m $project_name ..."

echo -e "------------------------------------------------------"
docker-compose -p "$project_name" up -d

echo -e "------------------------------------------------------"
./setup.sh

echo -e "------------------------------------------------------"
./run.sh

echo "End!"
