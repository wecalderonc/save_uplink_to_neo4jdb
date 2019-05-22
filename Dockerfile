FROM ruby:2.5.0
MAINTAINER tecnologia@zonawiki.com

ENV LANG=C.UTF-
ENV LC_ALL=C.UTF-8

RUN gem install bundler

RUN apt-get install -y python3 && \
    apt-get update && \
    apt-get install -y python3-pip && \
    pip3 install awscli

ADD .aws/ /root/.aws
ADD .ssh/ /root/.ssh

RUN mkdir /lambda_docker
WORKDIR /lambda_docker
