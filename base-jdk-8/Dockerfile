FROM jbonjean/base-ubuntu-20.04

RUN apt-get update && \
	mkdir -p /usr/share/man/man1 && \
	eatmydata apt-get install -y --no-install-recommends openjdk-8-jdk maven gradle && \
	update-java-alternatives -s java-1.8.0-openjdk-amd64 && \
	rm -rf /usr/share/man/* && \
	cleanup
