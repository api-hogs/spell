use Mix.Config

config :spell, Spell.Endpoint,
  http: [port: 8888]

config :logger,
  backends: [{LoggerFileBackend, :error_log}]

config :logger, :error_log,
  path: "/var/www/spell/production.log",
  level: :error

config :phoenix, :serve_endpoints, true

config :spell, Spell.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "spell",
  pool_size: 10
