# hubot-wormhole

This is a hubot for connecting a slack team and other slack teams via Message Queue.

A slack team view.
<img width="243" alt="A slack team view"
src="https://user-images.githubusercontent.com/210692/38567935-54a42bb0-3d22-11e8-8254-382550b95752.png">

Other slack team view.
<img width="257" alt="Other slack team view"
src="https://user-images.githubusercontent.com/210692/38567969-6ab04312-3d22-11e8-8bce-adb806d2f607.png">

The following example explain the operation:

<img width="719" alt="Operation image"
src="https://user-images.githubusercontent.com/210692/38569327-e9cf90c8-3d25-11e8-825e-b423f6e3dff4.png">

1. Slack A sends a message with the routing key as "routing.key".
2. Slack B gets a message from queue with the binding key as "routing.key"
3. Slack C gets a message from queue with the binding key as "routing.*".
4. Slack C sends a message with the routing key as "your.routing.key".
5. Slack B gets a message from queue with the binding key as "your.#"

"*" (star) can substitute for exactly one word.
"#" (hash) can substitute for zero or more words.

Message exchanges can be set for one way and two way!

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
