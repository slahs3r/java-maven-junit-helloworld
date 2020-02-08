FROM ubuntu:16.04
LABEL MAINTAINER Bohdan

ENV DEBIAN_FRONTEND noninteractive
ENV JAVA_HOME       /usr/lib/jvm/java-8-openjdk-amd64/
ENV LANG            en_US.UTF-8
ENV LC_ALL          en_US.UTF-8

ADD $WORKSPACE/target/java-maven-junit-helloworld-2.0-SNAPSHOT.jar /

RUN apt-get update && \
  apt-get install -y --no-install-recommends locales && \
  locale-gen en_US.UTF-8 && \
  apt-get --purge remove openjdk* && \
  apt-get install -y openjdk-8-jdk && \
  apt-get clean all

CMD java -cp target/java-maven-junit-helloworld-2.0-SNAPSHOT.jar com.example.javamavenjunithelloworld.HelloApp

