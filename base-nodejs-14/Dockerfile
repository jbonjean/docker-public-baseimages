FROM jbonjean/base-ubuntu-20.04

RUN export VERSION="14.17.4" SHA256="db18c54ebe01974d46198b08729249acbb0dcdc9aea82b53eec913f8c56035c6" && \
	curl -Lo /tmp/nodejs.tar.xz "https://nodejs.org/download/release/v$VERSION/node-v$VERSION-linux-x64.tar.xz" && \
	sha256sum /tmp/nodejs.tar.xz && \
	echo "$SHA256 /tmp/nodejs.tar.xz" | sha256sum --check --status && \
	mkdir -p /opt/node && \
	tar --strip-components 1 -C /opt/node -xf /tmp/nodejs.tar.xz && \
	rm -f /tmp/nodejs.tar.xz

ENV PATH=/opt/node/bin:$PATH
