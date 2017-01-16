#!/bin/bash

sed -i -r 's|#(log4j.appender.ROLLINGFILE.MaxBackupIndex.*)|\1|g' $ZK_HOME/conf/log4j.properties
sed -i -r 's|#autopurge|autopurge|g' $ZK_HOME/conf/zoo.cfg

ZK_PID=0

# see https://medium.com/@gchudnov/trapping-signals-in-docker-containers-7a57fdda7d86#.bh35ir4u5
term_handler() {
  echo 'Stopping Kafka....'
  if [ $ZK_PID -ne 0 ]; then
    kill -s TERM "$ZK_PID"
    wait "$ZK_PID"
  fi
  echo 'Zookeeper stopped.'
  exit
}

# Capture kill requests to stop properly
trap term_handler SIGHUP SIGINT SIGTERM
/opt/zookeeper-3.5.2-alpha/bin/zkServer.sh start-foreground &
ZK_PID=$!

wait "$ZK_PID"
