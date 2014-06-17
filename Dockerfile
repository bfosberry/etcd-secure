FROM coreos/etcd

ADD ./run.sh /opt/etcd/run.sh

VOLUME /opt/keys

ENTRYPOINT ["/opt/etcd/run.sh"] 
