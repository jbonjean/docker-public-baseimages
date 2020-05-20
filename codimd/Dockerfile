FROM jbonjean/base-nodejs-8 as builder

RUN apt-get update && \
	eatmydata apt-get install -y --no-install-recommends build-essential git-core libssl-dev python && \
	cleanup

ENV VERSION=1.4.1

RUN mkdir -p /dist/codimd && \
	curl -L https://github.com/hackmdio/codimd/archive/${VERSION}.tar.gz | \
		tar --strip-components=1 -C /dist/codimd -xz

WORKDIR /dist/codimd
RUN eatmydata yarn install --pure-lockfile
RUN eatmydata yarn install --production=true --pure-lockfile
RUN eatmydata yarn global add webpack
RUN eatmydata yarn add webpack-cli --dev

COPY patches /tmp/patches
RUN for P in /tmp/patches/*.patch; do patch -p1 < ${P}; done

RUN eatmydata npm run build
RUN eatmydata yarn install
RUN eatmydata yarn cache clean

# Fixing migration scripts for sqlite support.
RUN find /dist/codimd/lib/migrations/ -type f -exec sed -r -i \
	"s#error.message === "'"'"ER_DUP_FIELDNAME: Duplicate column name '([^']+)'"'"'"#error.message.match(/: duplicate column name:? '?\1'?/i)#" "{}" \;



FROM jbonjean/base-nodejs-8

RUN apt-get update && \
	eatmydata apt-get install -y --no-install-recommends libfontconfig1 && \
	cleanup

RUN groupadd codimd -g 5000 && \
	useradd --system --uid 5000 --gid 5000 codimd

COPY --from=builder --chown=codimd:codimd /dist/codimd /opt/codimd

COPY config.json /opt/codimd/config.json
COPY sequelizerc /opt/codimd/.sequelizerc
COPY etc /etc
