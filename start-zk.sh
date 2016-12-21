sed -i -r 's|#(log4j.appender.ROLLINGFILE.MaxBackupIndex.*)|\1|g' $ZK_HOME/conf/log4j.properties
sed -i -r 's|#autopurge|autopurge|g' $ZK_HOME/conf/zoo.cfg

## put the hostname into myid file, good for clusters
hostname > /opt/zookeeper-3.4.9/data/myid

/opt/zookeeper-3.4.9/bin/zkServer.sh start-foreground
