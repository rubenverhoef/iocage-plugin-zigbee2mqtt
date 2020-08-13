#!/bin/sh

# Clone Zigbee2MQTT repository
git clone https://github.com/Koenkk/zigbee2mqtt.git /home/root/zigbee2mqtt

# Make python command accessible
ln -s /usr/local/bin/python3.7 /usr/local/bin/python

# Install dependencies
cd /home/root/zigbee2mqtt && npm ci

# Custom network key
echo "" >> /home/root/zigbee2mqtt/data/configuration.yaml
echo "advanced:" >> /home/root/zigbee2mqtt/data/configuration.yaml
echo "    network_key: GENERATE" >> /home/root/zigbee2mqtt/data/configuration.yaml
echo "" >> /home/root/zigbee2mqtt/data/configuration.yaml
