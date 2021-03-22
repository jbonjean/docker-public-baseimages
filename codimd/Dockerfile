FROM jbonjean/base-nodejs-10 as builder

RUN apt-get update && \
	eatmydata apt-get install -y --no-install-recommends build-essential git-core libssl-dev python && \
	cleanup

ENV VERSION=2.3.2
ENV SHA256=aa1134ed283aec23e99ae3557541e183f342031e6728d1045ec5c3b2d32b2e5f

RUN curl -Lo /tmp/codimd.tar.gz "https://github.com/hackmdio/codimd/archive/$VERSION.tar.gz" && \
	sha256sum /tmp/codimd.tar.gz && \
	echo "$SHA256 /tmp/codimd.tar.gz" | sha256sum --check --status && \
	mkdir -p /dist/codimd && \
	tar --strip-components=1 -C /dist/codimd -xf /tmp/codimd.tar.gz && \
	rm -f /tmp/codimd.tar.gz

WORKDIR /dist/codimd

COPY patches /tmp/patches
RUN for P in /tmp/patches/*.patch; do patch -p1 < ${P}; done

RUN eatmydata npm ci
RUN eatmydata npm run build
RUN eatmydata npm prune --production
RUN eatmydata npm install sqlite3@5.0.0



FROM jbonjean/base-nodejs-10

RUN apt-get update && \
	eatmydata apt-get install -y --no-install-recommends libfontconfig1 && \
	cleanup

RUN groupadd codimd -g 5000 && \
	useradd --system --uid 5000 --gid 5000 codimd

COPY --from=builder --chown=codimd:codimd /dist/codimd /opt/codimd

COPY config.json /opt/codimd/config.json
COPY sequelizerc /opt/codimd/.sequelizerc
COPY etc /etc
