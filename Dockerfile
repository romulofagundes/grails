FROM adoptopenjdk/openjdk8-openj9:alpine-slim

# Set Grails version (max version for this Docker image is: 2.5.6).
ENV GRAILS_VERSION 2.5.6
ENV MAVEN_VERSION 3.8.1

WORKDIR /opt/java/openjdk

USER root

# Install Grails
RUN apk update && \
    apk add ca-certificates wget curl && \
    update-ca-certificates && \
    wget -q https://downloads.apache.org/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.zip && \
    unzip apache-maven-$MAVEN_VERSION-bin.zip && \
    wget -q https://github.com/grails/grails-core/releases/download/v$GRAILS_VERSION/grails-$GRAILS_VERSION.zip && \
    unzip -q grails-$GRAILS_VERSION.zip && \
    rm -rf grails-$GRAILS_VERSION.zip /var/cache/apk/* apache-maven-$MAVEN_VERSION-bin.zip && \
    ln -s grails-$GRAILS_VERSION grails && \
    ln -s apache-maven-$MAVEN_VERSION maven

# Setup Grails path.
ENV GRAILS_HOME /opt/java/openjdk/grails
ENV MAVEN_HOME /opt/java/openjdk/maven
ENV PATH $GRAILS_HOME/bin:$MAVEN_HOME/bin:$PATH