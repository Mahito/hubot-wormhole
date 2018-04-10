# hubot-wormhole

This is a hubot for connecting a slack team and other slack teams via Message Queue.

## Requirements

* Message Queu that can use AMQP (eg RabbitMQ)
* NodeJS
* NPM
* git

## Installation

```
$ git clone https://github.com/Mahito/hubot-wormhole
```

## Configuring

|環境変数|値|概要|
|--|--|--|
|HUBOT_AMQP_USER|string|AMQP user name|
|HUBOT_AMQP_PASSWORD|string|AMQP user password|
|HUBOT_AMQP_URL|string|AMQP HOST URL|
|HUBOT_WORMHOLE_ROUTING_KEY|string|The routing key name to set for exchange|
|HUBOT_WORMHOLE_BINDING_KEYS|string[,string,...]|The names of the Key to bind to the Queue|
|HUBOT_WORMHOLE_IN|yes/no|Whether to put messages in the wormhole|
|HUBOT_WORMHOLE_OUT|yes/no|Whether to get messages from the wormhole|
|HUBOT_EXHALE_ROOM|string|The name of the channel that exhale the error|
|HUBOT_SLACK_TOKEN|string|Slack's token|

## Quick Start

```
$ git clone https://github.com/Mahito/hubot-wormhole
$ cd hubot-wormhole
$ cp docker-compose.yml.sample docker-compose.yml
$ vim docker-compose.yml
$ dcoker-compose up -d rabbitmq
$ dcoker-compose up -d
```

## Contributing

Bug reports and pull requests are welcome on GitHub at　https://github.com/Mahito/hubot-wormhole

## Development

```
$ git clone https://github.com/Mahito/hubot-wormhole
$ cd hubot-wormhole
$ export HUBOT_AMQP_USER=...
$ export HUBOT_AMQP_PASSWORD=...
$ export HUBOT_AMQP_URL=...
$ export HUBOT_WORMHOLE_ROUTING_KEY=...
$ export HUBOT_WORMHOLE_BINDING_KEYS=...
$ export HUBOT_WORMHOLE_IN=yes
$ export HUBOT_WORMHOLE_OUT=yes
$ export HUBOT_EXHALE_ROOM=...
$ export HUBOT_SLACK_TOKEN=...
$ ./entrypoint.sh
```
