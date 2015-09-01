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

To check that the application started, run `rel/spell/bin/spell ping`. The output should be `pong`. Notice that the application will not start if you did not specify the `PORT` environment variable. You can also check that the web server responds by running `curl http://127.0.0.1:4000/api/v1/messages`. You should get `{"error":"unauthorized"}`.
