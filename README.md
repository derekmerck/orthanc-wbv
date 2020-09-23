# DerekMerck/Orthanc-cwbv

Derek Merck  
derek.merck@ufl.edu  
Summer 2020  

Docker image from the latest [Orthanc][] including [confd][] for configuration management and the [Osimis][] WebViewer plugin installed by default.

[Orthanc]: https://orthanc-server.com
[confd]: https://github.com/kelseyhightower/confd
[Osimis]: https://www.osimis.io/en/

## Basic Usage

```bash
$ docker run --rm -d -p 8042:8042 derekmerck/orthanc-cwbv
```

## Warning

This image has a default user "orthanc" with password "passw0rd".  Remove this user or update the password in any production environment.

This clears it (assuming $ORTHANC_USERS_ORTHANC is not set on the host.)
```
$ docker run -p 8042:8042 -e ORTHANC_USERS_ORTHANC derekmerck/orthanc-cwbv
```

Configure from environment like this:
```
docker run -e ORTHANC_NAME="Orthanc" \
           -e ORTHANC_AET="ORTHANC" \
           -e ORTHANC_PEERS_NODE1="addr,admin,my_passw0rd" \
           -e ORTHANC_USERS_ORTHANC="my_passw0rd" \
           -e ORTHANC_USERS_USER1="my_passw0rd" \
           -p 8042:8042
       diana/orthanc-cwbv
```

Or mount a `json` or `yaml` file and configure from file.**(Currently broken.)
```json
{
  "name":"Orthanc",
  "aet": "ORTHANC",
  "peers":{"node1": "addr1,user1,pwd1", 
           "node2": "addr2,user2,pwd2"}, 
  "users":{"user3": "pwd3", 
           "user4": "pwd4"}
}
```
```bash
docker run -v config.json:/config.json \
           -e ORTHANC_CONFIG_FILE="/config.json" \
           -p 8042:8042
       diana/orthanc
```

See https://play.golang.org/p/1mA_CRbMfBl for a `golang/template` test script.

## License

MIT
