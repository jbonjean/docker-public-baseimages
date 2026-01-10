FROM jbonjean/base-jre-25

RUN apt-get update && \
	mkdir -p /usr/share/man/man1/ && \
	eatmydata apt-get install -y --no-install-recommends openjdk-25-jdk && \
	update-java-alternatives -s java-1.25.0-openjdk-amd64 && \
	rm -rf /usr/share/man/* && \
	cleanup

# Manually install Maven.
RUN export VERSION="3.9.12" && \
	curl -Lo /tmp/maven.tar.gz "https://dlcdn.apache.org/maven/maven-3/$VERSION/binaries/apache-maven-$VERSION-bin.tar.gz" && \
	SHA512="$(curl -sL "https://downloads.apache.org/maven/maven-3/$VERSION/binaries/apache-maven-$VERSION-bin.tar.gz.sha512")" && \
	echo "$SHA512 /tmp/maven.tar.gz" | sha512sum --check --status && \
	mkdir -p /opt/maven && \
	tar --strip-components 1 -C /opt/maven -xf /tmp/maven.tar.gz && \
	rm -f /tmp/maven.tar.gz

ENV PATH=/opt/maven/bin:$PATH
