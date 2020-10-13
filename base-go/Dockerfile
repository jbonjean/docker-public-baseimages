FROM jbonjean/base-ubuntu-20.04

ENV GOPATH=/go GOROOT=/opt/go PATH=/opt/go/bin:/sbin:/usr/sbin:/usr/local/bin:/usr/bin:/bin

RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH"
WORKDIR $GOPATH

RUN export VERSION="1.15.2" SHA256="b49fda1ca29a1946d6bb2a5a6982cf07ccd2aba849289508ee0f9918f6bb4552" && \
	curl -Lo /tmp/golang.tar.gz "https://storage.googleapis.com/golang/go$VERSION.linux-amd64.tar.gz" && \
	echo "$SHA256 /tmp/golang.tar.gz" | sha256sum --check --status && \
	mkdir -p /opt/go && \
	tar -C /opt/go --strip-components=1 -xf /tmp/golang.tar.gz && \
	rm -f /tmp/golang.tar.gz

# Deprecated.
RUN curl -L 'https://github.com/golang/dep/releases/download/v0.5.4/dep-linux-amd64' -o /usr/local/bin/dep && \
	chmod +x /usr/local/bin/dep
