FROM openjdk:8-jre-alpine

MAINTAINER Andrii Petruk <andrey.petruk@gmail.com>

ENV ZK_VERSION=3.4.10 \
    logDir=/datalog \
    confDir=/conf \
    dataDir=/data \
    clientPort=2181 \
    maxClientCnxns=0 \
    tickTime=2000 \
    initLimit=10 \
    syncLimit=5 

RUN apk add --no-cache bash su-exec wget ca-certificates  tar 

RUN wget http://www.apache.org/dist/zookeeper/zookeeper-$ZK_VERSION/zookeeper-$ZK_VERSION.tar.gz && \
    tar -zxvf zookeeper-$ZK_VERSION.tar.gz && \
    rm zookeeper-$ZK_VERSION.tar.gz && \
    mv zookeeper-$ZK_VERSION /zk  && \
    mkdir -p $logDir $confDir  $dataDir

WORKDIR /zk
VOLUME ["$dataDir", "$logDir", "$confDir"]

EXPOSE $clientPort 2888 3888

ENV PATH=$PATH:/zk/bin \
    ZOOCFGDIR=$confDir

COPY config.sh /
ENTRYPOINT ["/config.sh"]
CMD ["zkServer.sh", "start-foreground"]
