FROM jbonjean/base-ubuntu-18.04

RUN apt-get update && \
	mkdir -p /usr/share/man/man1 && \
	eatmydata apt-get install -y --no-install-recommends openjdk-8-jre && \
	rm -rf /usr/share/man/* && \
	cleanup
