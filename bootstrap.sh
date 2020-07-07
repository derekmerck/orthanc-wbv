#! /bin/bash

echo "Creating Orthanc config file"
confd -confdir /etc/confd/orthanc -onetime --backend env

cat /etc/orthanc/orthanc.json

echo "Starting Orthanc"

if [ -z "$ORTHANC_VERBOSE" ]; then
    exec Orthanc /etc/orthanc/orthanc.json
else
    exec Orthanc /etc/orthanc/orthanc.json --verbose
fi

