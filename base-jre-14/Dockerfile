FROM jbonjean/base-ubuntu-20.04

RUN apt-get update && \
	mkdir -p /usr/share/man/man1/ && \
	eatmydata apt-get install -y --no-install-recommends openjdk-14-jre && \
	rm -rf /usr/share/man/* && \
	cleanup
