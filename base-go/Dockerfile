FROM jbonjean/base-ubuntu-20.04

ENV PATH=/opt/go/bin:/sbin:/usr/sbin:/usr/local/bin:/usr/bin:/bin

RUN export VERSION="1.17.5" SHA256="bd78114b0d441b029c8fe0341f4910370925a4d270a6a590668840675b0c653e" && \
	curl -Lo /tmp/golang.tar.gz "https://storage.googleapis.com/golang/go$VERSION.linux-amd64.tar.gz" && \
	echo "$SHA256 /tmp/golang.tar.gz" | sha256sum --check --status && \
	mkdir -p /opt/go && \
	tar -C /opt/go --strip-components=1 -xf /tmp/golang.tar.gz && \
	rm -f /tmp/golang.tar.gz
