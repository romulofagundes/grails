FROM adoptopenjdk/openjdk8-openj9:alpine-slim

# Set Grails version (max version for this Docker image is: 2.5.6).
ENV GRAILS_VERSION 2.5.6

WORKDIR /opt/java/openjdk
# Install Grails
RUN apk update && \
    apk add ca-certificates wget curl && \
    update-ca-certificates && \
    wget -q https://github.com/grails/grails-core/releases/download/v$GRAILS_VERSION/grails-$GRAILS_VERSION.zip && \
    unzip -q grails-$GRAILS_VERSION.zip && \
    rm -rf grails-$GRAILS_VERSION.zip /var/cache/apk/* && \
    ln -s grails-$GRAILS_VERSION grails

# Setup Grails path.
ENV GRAILS_HOME /opt/java/openjdk/grails
ENV PATH $GRAILS_HOME/bin:$PATH