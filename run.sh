#!/bin/bash

echo -e "\e[35mRunning issue\e[0m..."

source data/data.sh

timestamp=$(date +%s)

echo -e "Sending data (50 <-> 150) to \e[93m$deviceId_000\e[0m..."
python3 emulator.py "$api_key" "$iot_ul_host" "$iot_ul_port" "$deviceId_000" "$timestamp" "100" "50" "150" &
deviceId_000_emulator_pid=$(echo $!)
echo -e "Device \e[93m$deviceId_000\e[0m emulator got pid \e[92m$deviceId_000_emulator_pid\e[0m"


echo -e "Now, we wait for the emulator to generate some values at each minute for device \e[93m$deviceId_000\e[0m. A log is being generated in \e[93m"$deviceId_000"."$timestamp".log\e[0m ..."
echo -e "In the meanwhile, you can check aggreagates generation by running  \e[93m'./check_aggr.sh $fiware_service $fiware_path $deviceId_000 $attrName'\e[0m or just connect to mongodb."

echo -e "Waiting \e[93m5' 30''\e[0m"
sleep 330

echo -e "------------------------------------------------------"
echo -e "Now, we start the second emulator to generate some values at each minute for device \e[93m$deviceId_001\e[0m. A log is being generated in \e[93m"$deviceId_001"."$timestamp".log\e[0m ..."
echo -e "Notice that aggregates for the first device stops being generated and those generated for the second, contains two samples per record (should be one as record's id is supposed to belong to just one device)."
echo -e "Also, min/max values per record are affected by these samples, poisoning the data."
echo -e "As before, you can check aggreagates generation by running  \e[93m'./check_aggr.sh $fiware_service $fiware_path $deviceId_001 $attrName'\e[0m or just connect to mongodb."

echo -e "Sending data (4950 <-> 5050) to \e[93m$deviceId_001\e[0m..."
python3 emulator.py "$api_key" "$iot_ul_host" "$iot_ul_port" "$deviceId_001" "$timestamp" "5000" "4950" "5050" &
deviceId_001_emulator_pid=$(echo $!)
echo -e "Device \e[93m$deviceId_001\e[0m emulator got pid \e[92m$deviceId_001_emulator_pid\e[0m"

echo -e "Waiting \e[93m5' 30''\e[0m"
sleep 330

echo -e "Killing emulator \e[92m$deviceId_000_emulator_pid\e[0m ..."
kill $deviceId_000_emulator_pid

echo -e "Killing emulator \e[92m$deviceId_001_emulator_pid\e[0m ..."
kill $deviceId_001_emulator_pid

echo -e "Issue replication finished. Now you can check the result in mongodb."
