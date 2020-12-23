FROM jbonjean/base-ubuntu-20.04

RUN export VERSION="10.23.0" SHA256="3293b1ea9b9e08d9dbc5bb8717a80084e24cadfe3b030a8ebfdadea5f963dfc9" && \
	curl -Lo /tmp/nodejs.tar.xz "https://nodejs.org/download/release/v$VERSION/node-v$VERSION-linux-x64.tar.xz" && \
	sha256sum /tmp/nodejs.tar.xz && \
	echo "$SHA256 /tmp/nodejs.tar.xz" | sha256sum --check --status && \
	mkdir -p /opt/node && \
	tar --strip-components 1 -C /opt/node -xf /tmp/nodejs.tar.xz && \
	rm -f /tmp/nodejs.tar.xz

ENV PATH=/opt/node/bin:$PATH
