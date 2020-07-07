# Vanilla Orthanc w Confd and Osimis WebViewer
# Derek Merck, Fall 2018

FROM jodogne/orthanc:latest

ARG CONFD_PKG="https://github.com/kelseyhightower/confd/releases/download/v0.16.0/confd-0.16.0-linux-amd64"

RUN wget $CONFD_PKG --output-document /usr/local/bin/confd
RUN chmod +x /usr/local/bin/confd

RUN mkdir -p /etc/confd/{conf.d,templates}
COPY orthanc.json.toml /etc/confd/orthanc/conf.d/
COPY orthanc.json.tmpl /etc/confd/orthanc/templates/

COPY bootstrap.sh /usr/local/bin/bootstrap.sh
RUN chmod +x /usr/local/bin/bootstrap.sh

RUN mkdir -p /usr/share/orthanc/plugins
# RUN wget http://orthanc.osimis.io/lsb/plugin-osimis-webviewer/releases/1.3.1/libOsimisWebViewer.so --output-document /usr/share/orthanc/plugins/libOsimisWebViewer.so
COPY libOsimisWebViewer.so /usr/share/orthanc/plugins/
RUN chmod +x /usr/share/orthanc/plugins/*

ENTRYPOINT /usr/local/bin/bootstrap.sh

# Default othanc:passw0rd user
ENV ORTHANC_USERS_ORTHANC=passw0rd

HEALTHCHECK --interval=5s --timeout=2s --start-period=10s CMD bash -c "printf 'GET / HTTP/1.1\n\n' > /dev/tcp/127.0.0.1/8042"
