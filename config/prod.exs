use Mix.Config

config :spell, Spell.Endpoint,
  http: [port: {:system, "PORT"}],
  url: [host: "example.com", port: 80],
  cache_static_manifest: "priv/static/manifest.json"

config :logger, level: :info

config :phoenix, :serve_endpoints, true

# import_config "prod.secret.exs"
