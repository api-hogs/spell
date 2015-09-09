# Spell

[![Build Status](https://travis-ci.org/api-hogs/spell.svg)](https://travis-ci.org/api-hogs/spell)

To start your new Phoenix application:

1. Install dependencies with `mix deps.get`
2. Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Deployment

Clone the project to your server. Install erlang, rebar and elixir packages. Modify production database and redis connection options.

In the project directory run:

```
mix deps.get
MIX_ENV=prod mix release
PORT=4000 rel/spell/bin/spell start
```

To check that the application started, run `rel/spell/bin/spell ping`. The output should be `pong`. Notice that the application will not start if you did not specify the `PORT` environment variable. You can also check that the web server responds by running `curl http://127.0.0.1:4000/api/v1/chat/messages`. You should get `{"error":"unauthorized"}`.

## Chat Socket API

The websocket is available at `/api/v1/chat/websocket`. The communication is performed by emitting and receiving events. All events sent to and received from the socket are JSON-encoded objects with four keys: `topic`, `event`, `payload` and `ref`.

The value of `ref` in the first event that you emit should be `"1"`, and should be incremented in all subsequent events that you send, e.g. `"2"`, `"3"`. When you receive an event with a non-null `ref`, it means that the event was not broadcasted, but was instead sent to you as a response to your event with the same `ref`.

First, you have to subscribe to the topic of a user. All messages sent from and to this user will be broadcasted in this topic. To do that, you must emit en event `phx_join` to the topic of a user. The name of the topic has the form `messages:<user_id>`. You must also provide an authentication token of that user to subscribe. Here is an example of a subscription event: 
```json
{
  "topic":"messages:1",
  "event":"phx_join",
  "payload":{"token":"foo"},
  "ref":"1"
}
```
After emitting this event, you will receive a `phx_reply` event. If the authentication and subscription succeeded, the event will look like this: 
```json
{
  "topic":"messages:1",
  "ref":"1",
  "payload":{"status":"ok","response":{}},
  "event":"phx_reply"
}
```
If the authentication fails, the event will look like this:
```json
{
  "topic":"messages:1",
  "ref":"1",
  "payload":{"status":"error","response":{"reason":"unauthorized"}},
  "event":"phx_reply"
}
```

When subscribed, you can send and receive messages. An incoming messsage will arrive as a `message_received` event:
```json
{
  "topic":"messages:1",
  "ref":null,
  "payload":{"sender_id":2,"recipient_id":1,"read":false,"id":1,"body":"hello!"},
  "event":"message_received"
}
```

To send a message, emit a `message_sent` event:
```json
{
  "topic":"messages:1",
  "event":"message_sent",
  "payload":{"recipient_id":2,"body":"hi, how r u?"},
  "ref":"2"
}
```
This will cause two events to be broadcasted: a `message_received` in the channel of the recipient `messages:2`, and a `message_sent` in the channel of the sender `messages:1`. If a user is logged in on multiple devices, he will receive messages sent by him from other devices in `message_sent` events.
