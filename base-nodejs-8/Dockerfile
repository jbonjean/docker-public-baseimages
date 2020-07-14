FROM jbonjean/base-ubuntu-20.04

RUN export VERSION="8.17.0" SHA256="b7f6dd77fb173c8c7c30d61d0702eefc236bba74398538aa77bfa2bb47bddce6" && \
	curl -Lo /tmp/nodejs.tar.xz "https://nodejs.org/download/release/v$VERSION/node-v$VERSION-linux-x64.tar.xz" && \
	echo "$SHA256 /tmp/nodejs.tar.xz" | sha256sum --check --status && \
	mkdir -p /opt/node && \
	tar --strip-components 1 -C /opt/node -xf /tmp/nodejs.tar.xz && \
	rm -f /tmp/nodejs.tar.xz

ENV PATH=/opt/node/bin:$PATH
