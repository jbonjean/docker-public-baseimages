FROM jbonjean/base-ubuntu-20.04

RUN export VERSION="10.21.0" SHA256="1d3296763e46540047099e4910812e81c4899c0595f2d82474e2099c1e1603e2" && \
	curl -Lo /tmp/nodejs.tar.xz "https://nodejs.org/download/release/v$VERSION/node-v$VERSION-linux-x64.tar.xz" && \
	echo "$SHA256 /tmp/nodejs.tar.xz" | sha256sum --check --status && \
	mkdir -p /opt/node && \
	tar --strip-components 1 -C /opt/node -xf /tmp/nodejs.tar.xz && \
	rm -f /tmp/nodejs.tar.xz

ENV PATH=/opt/node/bin:$PATH
