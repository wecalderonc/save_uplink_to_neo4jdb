FROM ruby:2.5.0
MAINTAINER tecnologia@zonawiki.com

ENV LANG=C.UTF-
ENV LC_ALL=C.UTF-8

RUN gem install bundler
RUN wget -O - http://debian.neo4j.org/neotechnology.gpg.key | apt-key add -
RUN echo 'deb http://debian.neo4j.org/repo stable/' > /etc/apt/sources.list.d/neo4j.list

RUN apt-get update
RUN apt-get install software-properties-common -y
RUN add-apt-repository ppa:openjdk-r/ppa -y
RUN apt-get install openjdk-8-jdk -y

RUN apt-get install neo4j -y

RUN apt-get install -y python3 && \
    apt-get install -y python3-pip && \
    pip3 install awscli

ADD .aws/ /root/.aws
ADD .ssh/ /root/.ssh

RUN mkdir /lambda_docker
WORKDIR /lambda_docker
