use Mix.Config

config :spell, Spell.Endpoint,
  http: [port: {:system, "PORT"}],
  url: [host: "example.com", port: 80]

config :logger, level: :info

config :phoenix, :serve_endpoints, true

config :spell, Spell.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "spell",
  pool_size: 10
