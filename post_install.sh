#!/bin/sh

ConfigFile="/home/root/zigbee2mqtt/data/configuration.yaml"

configure_config()
{
    if [ ! $(grep "^$1" "$ConfigFile") ]; then
        echo "" >> "$ConfigFile"
        echo "$1:" >> "$ConfigFile"
    fi

    begin=$(grep -n "^$1" "$ConfigFile" | cut -d ":" -f 1)
    list=$(grep "^[a-zA-Z]" "$ConfigFile")
    listbegin=$(echo "$list" | grep -n "^$1" | cut -d ":" -f 1)
    let "listbegin+=1"
    word=$(echo "$list" | sed -n -e "$listbegin"p)
    line=$(sed -n '/'$1'/,/'$word'/p' "$ConfigFile" | grep -n "$2" | cut -d ":" -f 1)

    if [ -z "$line" ]; then
        sed -i "s!$1:.*!&\n  $2: $3!" "$ConfigFile"
    else
        let "line=begin+line-1"
        sed -i ""$line"s!^  $2:.*!  $2: $3!" "$ConfigFile"
    fi
}

# Clone Zigbee2MQTT repository
git clone https://github.com/Koenkk/zigbee2mqtt.git /home/root/zigbee2mqtt

# Make python command accessible
ln -s /usr/local/bin/python3.8 /usr/local/bin/python

# Install dependencies
cd /home/root/zigbee2mqtt && npm ci

# Custom network key
configure_config "advanced" "network_key" "GENERATE"

# Enable frontend
configure_config "frontend" "port" "8080"
configure_config "experimental" "new_api" "true"

# install and enable service using pm2
npm install -g pm2
pm2 start /usr/local/bin/npm --name "zigbee2mqtt" -- start --prefix /home/root/zigbee2mqtt
pm2 save
pm2 startup
