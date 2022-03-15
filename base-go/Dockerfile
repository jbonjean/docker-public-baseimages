FROM jbonjean/base-ubuntu-20.04

ENV PATH=/opt/go/bin:/sbin:/usr/sbin:/usr/local/bin:/usr/bin:/bin

RUN export VERSION="1.17.8" SHA256="980e65a863377e69fd9b67df9d8395fd8e93858e7a24c9f55803421e453f4f99" && \
	curl -Lo /tmp/golang.tar.gz "https://storage.googleapis.com/golang/go$VERSION.linux-amd64.tar.gz" && \
	echo "$SHA256 /tmp/golang.tar.gz" | sha256sum --check --status && \
	mkdir -p /opt/go && \
	tar -C /opt/go --strip-components=1 -xf /tmp/golang.tar.gz && \
	rm -f /tmp/golang.tar.gz
