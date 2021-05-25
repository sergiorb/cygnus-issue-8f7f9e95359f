#!/bin/bash

echo "Cleaning up environment..."

source data/data.sh

declare -a arr=($(docker volume ls | awk '{print $2}' | grep "$project_name"))
for volume in "${arr[@]}"
do
  
  echo -e "Removing \e[93m$volume\e[0m..."
  docker volume rm $volume
done