FROM jbonjean/base-ubuntu-20.04

RUN export VERSION="14.18.2" SHA256="dae683f911fe5af11f1dc9d7746d80fccdb1e7b4bef31a570f5daffadd897c42" && \
	curl -Lo /tmp/nodejs.tar.xz "https://nodejs.org/download/release/v$VERSION/node-v$VERSION-linux-x64.tar.xz" && \
	sha256sum /tmp/nodejs.tar.xz && \
	echo "$SHA256 /tmp/nodejs.tar.xz" | sha256sum --check --status && \
	mkdir -p /opt/node && \
	tar --strip-components 1 -C /opt/node -xf /tmp/nodejs.tar.xz && \
	rm -f /tmp/nodejs.tar.xz

ENV PATH=/opt/node/bin:$PATH
