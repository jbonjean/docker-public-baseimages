FROM jbonjean/base-jre-17

RUN apt-get update && \
	mkdir -p /usr/share/man/man1/ && \
	eatmydata apt-get install -y --no-install-recommends openjdk-17-jdk && \
	update-java-alternatives -s java-1.17.0-openjdk-amd64 && \
	rm -rf /usr/share/man/* && \
	cleanup

# Manually install Maven, to avoid pulling jre-11 dependency.
RUN export VERSION="3.8.1" SHA256="b98a1905eb554d07427b2e5509ff09bd53e2f1dd7a0afa38384968b113abef02" && \
	curl -Lo /tmp/maven.tar.gz "https://httpd-mirror.sergal.org/apache/maven/maven-3/$VERSION/binaries/apache-maven-$VERSION-bin.tar.gz" && \
	sha256sum /tmp/maven.tar.gz && \
	echo "$SHA256 /tmp/maven.tar.gz" | sha256sum --check --status && \
	mkdir -p /opt/maven && \
	tar --strip-components 1 -C /opt/maven -xf /tmp/maven.tar.gz && \
	rm -f /tmp/maven.tar.gz

ENV PATH=/opt/maven/bin:$PATH
