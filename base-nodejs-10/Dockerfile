FROM jbonjean/base-ubuntu-20.04

RUN export VERSION="10.22.0" SHA256="ddf33e038c593d6df36b1dd4b25c1b6fa8230c615e6312ad33e80ef863e4a74f" && \
	curl -Lo /tmp/nodejs.tar.xz "https://nodejs.org/download/release/v$VERSION/node-v$VERSION-linux-x64.tar.xz" && \
	sha256sum /tmp/nodejs.tar.xz && \
	echo "$SHA256 /tmp/nodejs.tar.xz" | sha256sum --check --status && \
	mkdir -p /opt/node && \
	tar --strip-components 1 -C /opt/node -xf /tmp/nodejs.tar.xz && \
	rm -f /tmp/nodejs.tar.xz

ENV PATH=/opt/node/bin:$PATH
