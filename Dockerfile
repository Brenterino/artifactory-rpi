FROM adoptopenjdk/openjdk12:armv7l-ubuntu-jdk-12.0.2_10-slim

MAINTAINER Brenterino <me@brento.dev>

COPY qemu-arm-static /usr/bin

ENV AF_VERSION=6.13.1
ENV AF_SHA256=a77415f1adbfec0d574f3a808f1c17c35536a90299a630b96e65b4d698d968c7
ENV AF_HOME=/artifactory
ENV AF_BASE=artifactory-oss-${AF_VERSION}
ENV AF_DL_FILE=artifactory.zip
ENV AF_URL=https://bintray.com/jfrog/artifactory/download_file?file_path=jfrog-${AF_BASE}.zip

RUN apt-get update -yqq \
 && apt-get install -yqq curl unzip \
 && mkdir ${AF_HOME} \
 && cd ${AF_HOME} \
 && echo ${AF_SHA256} ${AF_DL_FILE} > ${AF_DL_FILE}.sha256 \
 && curl -Lk -o ${AF_DL_FILE} ${AF_URL} \
 && sha256sum -c ${AF_DL_FILE}.sha256 \
 && unzip -o ${AF_DL_FILE} \
 && mv ${AF_BASE}/* . \
 && sed -ri 's/4g/2g/g' bin/artifactory.default

VOLUME ${AF_HOME}/data
VOLUME ${AF_HOME}/logs
VOLUME ${AF_HOME}/backup
VOLUME ${AF_HOME}/etc/security

EXPOSE 8081

WORKDIR ${AF_HOME}

CMD bin/artifactory.sh

