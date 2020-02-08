FROM ubuntu:16.04
LABEL MAINTAINER Bohdan

ENV DEBIAN_FRONTEND noninteractive
ENV JAVA_HOME       /usr/lib/jvm/java-8-openjdk-amd64/
ENV LANG            en_US.UTF-8
ENV LC_ALL          en_US.UTF-8

RUN apt-get update && \
  apt-get install -y --no-install-recommends locales && \
  locale-gen en_US.UTF-8 && \
  apt-get --purge remove openjdk* && \
  apt-get install -y openjdk-8-jdk && \
  apt-get clean all
