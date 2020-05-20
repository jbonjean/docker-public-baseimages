FROM jbonjean/base-ubuntu-18.04

ENV GOPATH=/go GOROOT=/opt/go PATH=/opt/go/bin:/sbin:/usr/sbin:/usr/local/bin:/usr/bin:/bin

RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH"
WORKDIR $GOPATH

RUN mkdir -p /opt/go && \
	curl -L 'https://storage.googleapis.com/golang/go1.14.2.linux-amd64.tar.gz' | tar xz -C /opt/go --strip-components=1

RUN curl -L 'https://github.com/golang/dep/releases/download/v0.5.4/dep-linux-amd64' -o /usr/local/bin/dep && \
	chmod +x /usr/local/bin/dep
