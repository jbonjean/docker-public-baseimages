FROM jbonjean/base-ubuntu-18.04

RUN mkdir -p /opt/node && \
	curl -L https://nodejs.org/download/release/v8.17.0/node-v8.17.0-linux-x64.tar.xz | tar --strip-components 1 -C /opt/node -xJ && \
	PATH=$PATH:/opt/node/bin npm config set registry http://registry.npmjs.org/ --global && \
	PATH=$PATH:/opt/node/bin npm install --global gulp-cli bower yarn

ENV PATH=/opt/node/bin:$PATH
