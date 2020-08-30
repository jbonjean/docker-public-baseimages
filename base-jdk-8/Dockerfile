FROM jbonjean/base-ubuntu-20.04

RUN apt-get update && \
	mkdir -p /usr/share/man/man1/ && \
	eatmydata apt-get install -y --no-install-recommends openjdk-8-jdk && \
	update-java-alternatives -s java-1.8.0-openjdk-amd64 && \
	rm -rf /usr/share/man/* && \
	cleanup

# Manually install Maven, to avoid pulling jre-11 dependency.
RUN export VERSION="3.6.3" SHA256="26ad91d751b3a9a53087aefa743f4e16a17741d3915b219cf74112bf87a438c5" && \
	curl -Lo /tmp/maven.tar.gz "https://httpd-mirror.sergal.org/apache/maven/maven-3/$VERSION/binaries/apache-maven-$VERSION-bin.tar.gz" && \
	sha256sum /tmp/maven.tar.gz && \
	echo "$SHA256 /tmp/maven.tar.gz" | sha256sum --check --status && \
	mkdir -p /opt/maven && \
	tar --strip-components 1 -C /opt/maven -xf /tmp/maven.tar.gz && \
	rm -f /tmp/maven.tar.gz

ENV PATH=/opt/maven/bin:$PATH
