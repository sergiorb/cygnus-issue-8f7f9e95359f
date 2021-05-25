#!/bin/bash

echo -e "\e[35mRunning issue\e[0m..."

source data/data.sh

timestamp=$(date +%s)

echo -e "Sending data to \e[93m$deviceId_000\e[0m..."
python3 emulator.py "$api_key" "$iot_ul_host" "$iot_ul_port" "$deviceId_000" > $deviceId_000.$timestamp.log 2>&1 &
# python3 emulator.py "$api_key" "$iot_ul_host" "$iot_ul_port" "$deviceId_000"
deviceId_000_emulator_pid=$(echo $!)

echo -e "Device \e[93m$deviceId_000\e[0m emulator got pid \e[92m$deviceId_000_emulator_pid\e[0m"
