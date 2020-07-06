#!/bin/bash

DATE_STR=$(date +%Y-%m-%d)

BACKUP_DIR=tmp_dir=$(mktemp -d -t iot-stack-XXXXXXXXXX)

echo $BACKUP_DIR

docker run -v nodered-vol:/volume -v [output-dir]:/backup --rm loomchild/volume-backup backup $BACKUP_DIR/nodered-vol-$DATE_STR.tar.gz
docker run -v mqtt-vol:/volume -v [output-dir]:/backup --rm loomchild/volume-backup backup $BACKUP_DIR/mqtt-vol-$DATE_STR.tar.gz
docker run -v zigbee-vol:/volume -v [output-dir]:/backup --rm loomchild/volume-backup backup $BACKUP_DIR/zigbee-$DATE_STR.tar.gz

rsync -avr $BACKUP_DIR server.pyt.lan:/srv/backup
