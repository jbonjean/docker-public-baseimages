FROM jbonjean/base-ubuntu-20.04

ENV GOPATH=/go GOROOT=/opt/go PATH=/opt/go/bin:/sbin:/usr/sbin:/usr/local/bin:/usr/bin:/bin

RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH"
WORKDIR $GOPATH

RUN export VERSION="1.16.5" SHA256="b12c23023b68de22f74c0524f10b753e7b08b1504cb7e417eccebdd3fae49061" && \
	curl -Lo /tmp/golang.tar.gz "https://storage.googleapis.com/golang/go$VERSION.linux-amd64.tar.gz" && \
	echo "$SHA256 /tmp/golang.tar.gz" | sha256sum --check --status && \
	mkdir -p /opt/go && \
	tar -C /opt/go --strip-components=1 -xf /tmp/golang.tar.gz && \
	rm -f /tmp/golang.tar.gz
