FROM node
MAINTAINER Mahito <earthdragon77@gmail.com>
RUN apt update && apt upgrade -y

RUN mkdir /bot
ADD bin /bot/bin
ADD entrypoint.sh /bot/entrypoint.sh
ADD external-scripts.json /bot/external-scripts.json
ADD package.json /bot/package.json
ADD package-lock.json /bot/package-lock.json
ADD scripts /bot/scripts

WORKDIR /bot

ENTRYPOINT "./entrypoint.sh"
