FROM jbonjean/base-nodejs-8 as builder

RUN apt-get update && \
	eatmydata apt-get install -y --no-install-recommends \
	build-essential \
	libavahi-compat-libdnssd-dev \
	libudev-dev \
	python \
	&& cleanup



# Build Volumio Core.
FROM builder as core-builder

ENV CORE_VERSION=85a076a5a4334c69098e9e107b3ff45aa117d542
ENV SHA256=bf1223644aadec53f17bd29cb21dfd39e86adbf736b8286c1b616d6a09d5b877

RUN curl -Lo /tmp/volumio.tar.gz "https://github.com/volumio/Volumio2/archive/$CORE_VERSION.tar.gz" && \
	sha256sum /tmp/volumio.tar.gz && \
	echo "$SHA256 /tmp/volumio.tar.gz" | sha256sum --check --status && \
	mkdir -p /dist/volumio && \
	tar -C /dist/volumio --strip-components=1 -xf /tmp/volumio.tar.gz && \
	rm -f /tmp/volumio.tar.gz

# Remove fs-extra package that seems to cause issue on runtime. TBD.
RUN sed -i '/"fs-extra"/d' /dist/volumio/package.json

RUN cd /dist/volumio && \
	eatmydata npm install --production && \
	eatmydata node /dist/volumio/utils/misc/clean-node-modules.js /dist/volumio



# Build Volumio UI.
FROM builder as ui-builder

ENV UI_VERSION=2e630c6f51e216b2199a80902af0cb7d7fc6824b
ENV SHA256=99147e5443f25fd2d85bcec6c5e7b54bd0bd937ce05069a3fd794fee4b3e82a0

RUN curl -Lo /tmp/volumio-ui.tar.gz "https://github.com/volumio/Volumio2-UI/archive/$UI_VERSION.tar.gz" && \
	sha256sum /tmp/volumio-ui.tar.gz && \
	echo "$SHA256 /tmp/volumio-ui.tar.gz" | sha256sum --check --status && \
	mkdir -p /tmp/volumio-ui && \
	tar -C /tmp/volumio-ui --strip-components=1 -xf /tmp/volumio-ui.tar.gz && \
	rm -f /tmp/volumio-ui.tar.gz

RUN cd /tmp/volumio-ui && \
	eatmydata npm install && \
	eatmydata npm install -g bower gulp && \
	eatmydata bower install --allow-root && \
	eatmydata gulp build --theme="volumio" --env="production" && \
	mkdir -p /dist && mv /tmp/volumio-ui/dist /dist/volumio



# Build final image.
FROM jbonjean/base-nodejs-8

ARG DOCKER_TAG=latest

RUN apt-get update && \
	eatmydata apt-get install -y --no-install-recommends \
	alsa-utils \
	avahi-daemon \
	avahi-utils \
	libavahi-compat-libdnssd1 \
	libnss-mdns \
	minizip \
	mpc \
	mpd \
	pulseaudio \
	shairport-sync \
	sudo \
	wget \
	&& cleanup

# Add specific user and group (hardcoded).
RUN groupadd -g 1000 volumio && useradd -u 1000 -g 1000 volumio && \
	# add users to audio group
	usermod -a -G audio volumio && usermod -a -G audio mpd

# Install dist from previous stages.
COPY --from=core-builder /dist/volumio /volumio
COPY --from=ui-builder /dist/volumio /volumio/http/www

# Symlink library to /mnt for volumio.
RUN rm -rf /mnt && ln -s /var/lib/mpd/music /mnt && \
	# Create node symlink in /usr/local (hardcoded).
	ln -s /opt/node/bin/node /usr/local/bin/node

# Copy services and config.
COPY etc /etc

# A few additional hacks to finalize the image.
COPY volumio-image-hacks /tmp/
RUN /tmp/volumio-image-hacks

