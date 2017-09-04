#!/bin/bash



# Generate the config only if it doesn't exist
if [ ! -f "$confDir/zoo.cfg" ]; then
    CONFIG="$confDir/zoo.cfg"

    echo "clientPort=$clientPort" >> "$CONFIG"
    echo "dataDir=$dataDir" >> "$CONFIG"
    echo "dataLogDir=$dataLogDir" >> "$CONFIG"

    echo "tickTime=$tickTime" >> "$CONFIG"
    echo "initLimit=$initLimit" >> "$CONFIG"
    echo "syncLimit=$syncLimit" >> "$CONFIG"

    for server in $ZOO_SERVERS; do
        echo "$server" >> "$CONFIG"
    done
fi

# Write myid only if it doesn't exist
if [ ! -f "$dataDir/myid" ]; then
    echo "${myID:-1}" > "$dataDir/myid"
fi

exec "$@"
