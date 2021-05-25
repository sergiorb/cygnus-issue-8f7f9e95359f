#!/bin/bash

echo -e  "\e[35mSetting up environment\e[0m..."

source data/data.sh

iota_device000=$(cat data/iot-setup-foo-000.json)
iota_device001=$(cat data/iot-setup-foo-001.json)
orion_device000_subscription=$(cat data/orion-setup-foo-000.json)
orion_device001_subscription=$(cat data/orion-setup-foo-001.json)

echo -e -n "Creating device \e[93mfoo_000\e[0m in \e[92miota\e[0m..."
curl -s -i -X POST \
'http://localhost:4041/iot/devices' \
-H 'Content-Type: application/json' \
-H "fiware-service: $fiware_service" \
-H "fiware-servicepath: $fiware_path" \
-d "$(echo $iota_device000)" | head -1
echo ""

echo -e -n "Creating device \e[93mfoo_001\e[0m in \e[92miota\e[0m..."
curl -s -i -X POST \
'http://localhost:4041/iot/devices' \
-H 'Content-Type: application/json' \
-H "fiware-service: $fiware_service" \
-H "fiware-servicepath: $fiware_path" \
-d "$(echo $iota_device001)" | head -1
echo ""

echo -e -n "Creating device \e[93mfoo_000\e[0m \e[92msubscription\e[0m for cygnus..."
curl -s -i -X POST \
http://localhost:1026/v2/subscriptions \
-H 'Content-Type: application/json' \
-H "fiware-service: $fiware_service" \
-H "fiware-servicepath: $fiware_path" \
-d "$(echo $orion_device000_subscription)" | head -1
echo ""

echo -e -n "Creating device \e[93mfoo_001\e[0m \e[92msubscription\e[0m for cygnus..."
curl -s -i -X POST \
http://localhost:1026/v2/subscriptions \
-H 'Content-Type: application/json' \
-H "fiware-service: $fiware_service" \
-H "fiware-servicepath: $fiware_path" \
-d "$(echo $orion_device001_subscription)" | head -1
echo ""

echo "done!"
