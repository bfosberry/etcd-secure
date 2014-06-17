etcd-secure
===========

etcd-secure is a Docker container running etcd with a user provided secure key

This container was created following the [etcd security documentation](https://github.com/coreos/etcd/blob/master/Documentation/security.md).

To use this container you need to pass 3 environment args in

* CERT_FILE_DATA - The contents of the server crt file
* KEY_FILE_DATA - The contents of the server key file
* DISCOVERY_URL - The discovery url to use with this etcd server (optional)

Instead of passing the file contents, you can also mount the /opt/keys volume, 
and pass in the following env keys instead:
* CERT_FILE - The filename of the server crt file
* KEY_FILE - The filename of the server key file

### Running etcd 

```
docker run -e "CERT_FILE_DATA=foo" -e "KEY_FILE_DATA=bar" -e "DISCOVERY_URL=https://discovery.etcd.io/d29af1e5ef8df09c32f2d296cc0a9806" -t bfosberry/etcd-secure
```

You can also run this with the key files

```
docker run -v "/home/core/keys:/opt/keys" -e "CERT_FILE=/opt/keys/foo.crt" -e "KEY_FILE=/opt/keys/bar.key" -e "DISCOVERY_URL=https://discovery.etcd.io/d29af1e5ef8df09c32f2d296cc0a9806" -t bfosberry/etcd-secure
```

### Creating your keys

You can find a guide to creating your own keys [here](http://www.g-loaded.eu/2005/11/10/be-your-own-ca/) 
