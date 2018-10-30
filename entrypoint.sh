#!/bin/sh
CRON_DATA="/home/cron/volume"
CRON_FILE="my-crontab.yaml"
CRON_FILE_EXAMPLE="/var/tmp/crontab-example.yaml"

if [ ! -f ${CRON_DATA}/${CRON_FILE} ];then
  echo "${CRON_FILE} not found in ${CRON_DATA}!!! Default testing crontab ${CRON_FILE_EXAMPLE} file will be used"
  export CONFIG=${CRON_FILE_EXAMPLE} 
else
  export CONFIG="${CRON_DATA}/${CRON_FILE}"
fi

exec "$@"
