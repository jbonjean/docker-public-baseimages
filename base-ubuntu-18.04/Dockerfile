# STAGE 1: build s6

FROM ubuntu:bionic-20200807 as s6-builder

RUN echo force-unsafe-io > /etc/dpkg/dpkg.cfg.d/disable-fsync && \
	apt-get update && \
	apt-get install -y eatmydata && \
	dpkg -L eatmydata libeatmydata1 | grep 'libeatmydata.so$' > /etc/ld.so.preload && \
	eatmydata apt-get install -y autoconf automake build-essential curl git-core patch wget && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
	rm -f rm -f /var/cache/debconf/config.dat-old /var/cache/debconf/templates.dat-old && \
	find /var/log -type f -delete

COPY build-s6 /tmp/
RUN DIST_DIR=/dist /tmp/build-s6


# STAGE 2: build image

FROM ubuntu:bionic-20200807

ENV DEBIAN_FRONTEND=noninteractive LANG=en_US.UTF-8 TERM=xterm

RUN echo 'deb http://archive.ubuntu.com/ubuntu/ bionic main restricted universe multiverse' > /etc/apt/sources.list && \
	echo 'deb http://archive.ubuntu.com/ubuntu/ bionic-updates main restricted universe multiverse' >> /etc/apt/sources.list && \
	echo 'path-exclude=/usr/share/man/*' > /etc/dpkg/dpkg.cfg.d/docker-no-doc && \
	echo 'path-exclude=/usr/share/doc/*' >> /etc/dpkg/dpkg.cfg.d/docker-no-doc && \
	echo 'path-exclude=/usr/share/locale/*' >> /etc/dpkg/dpkg.cfg.d/docker-no-doc && \
	rm -rf /usr/share/man/ /usr/share/doc/ /usr/share/locale/ && \
	echo force-unsafe-io > /etc/dpkg/dpkg.cfg.d/disable-fsync && \
	apt-get update && \
	LANG=C apt-get install -y --no-install-recommends eatmydata locales apt-utils && \
	locale-gen en_US.UTF-8 && \
	update-locale && \
	eatmydata apt-get install -y --no-install-recommends \
	apt-transport-https \
	bzip2 \
	ca-certificates \
	curl \
	dirmngr \
	dnsutils \
	file \
	gettext-base \
	git-core \
	gosu \
	gpg-agent \
	htop \
	iputils-ping \
	jq \
	less \
	make \
	netcat-openbsd \
	net-tools \
	openssl \
	patch \
	procps \
	rsync \
	socat \
	socklog \
	software-properties-common \
	strace \
	sysstat \
	tcpdump \
	telnet \
	unzip \
	vim \
	whois \
	zip \
	&& \
	eatmydata apt-get purge -y \
	sysstat \
	&& \
	curl -L -o /usr/bin/tini https://github.com/krallin/tini/releases/download/v0.19.0/tini-static && \
	chmod +x /usr/bin/tini && \
	mkdir -p /etc/startup/ /etc/service/ && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
	rm -f rm -f /var/cache/debconf/config.dat-old /var/cache/debconf/templates.dat-old && \
	find /var/log -type f -delete

COPY --from=s6-builder /dist /

RUN mkdir -p /usr/lib/s6/shutdown.d /etc/service/.s6-svscan && \
	for signal in SIGINT SIGHUP SIGTERM SIGQUIT SIGUSR1 SIGUSR2; \
	do ln -s /usr/bin/s6-shutdown /etc/service/.s6-svscan/$signal; done && \
	rm -f /root/.bashrc /root/.profile && \
	rm -rf /run/systemd /run/mount

COPY etc /etc
COPY usr /usr

ENTRYPOINT ["/usr/bin/entrypoint"]
