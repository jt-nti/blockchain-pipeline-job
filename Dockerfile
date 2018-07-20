FROM node:8 AS build

USER node

RUN mkdir -p /home/node/bin

# Use non-root user for global dependencies.
ENV NPM_CONFIG_PREFIX=/home/node/.npm-global

# Install golang, using version 1.10.3 by default.
ARG GO_VERSION=1.10.3
RUN wget "https://storage.googleapis.com/golang/go${GO_VERSION}.linux-amd64.tar.gz" -O "/tmp/go${GO_VERSION}.linux-amd64.tar.gz"
RUN mkdir -p /home/node/golang
RUN tar -C /home/node/golang -xzf "/tmp/go${GO_VERSION}.linux-amd64.tar.gz"

# Install Composer, using version 0.19.5 by default.
ARG COMPOSER_VERSION=0.19.5
RUN npm install --production -g composer-cli@${COMPOSER_VERSION}

# Install jq, using version 1.5 by default.
ARG JQ_VERSION='1.5'
RUN wget --no-check-certificate https://raw.githubusercontent.com/stedolan/jq/master/sig/jq-release.key -O /tmp/jq-release.key
RUN wget --no-check-certificate https://raw.githubusercontent.com/stedolan/jq/master/sig/v${JQ_VERSION}/jq-linux64.asc -O /tmp/jq-linux64.asc
RUN wget --no-check-certificate https://github.com/stedolan/jq/releases/download/jq-${JQ_VERSION}/jq-linux64 -O /tmp/jq-linux64
RUN gpg --import /tmp/jq-release.key
RUN gpg --verify /tmp/jq-linux64.asc /tmp/jq-linux64
RUN cp /tmp/jq-linux64 /home/node/bin/jq
RUN chmod +x /home/node/bin/jq

FROM node:8

# Reset npm logging to default level.
ENV NPM_CONFIG_LOGLEVEL warn

# Copy results of build stage.
COPY --from=build /home/node/bin /usr/bin/
COPY --from=build --chown=root:staff /home/node/.npm-global /home/node/golang /usr/local/
