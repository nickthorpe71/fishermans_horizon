use Mix.Config

config :fishermans_horizon, FishermansHorizonWeb.Endpoint,
  http: [port: {:system, "PORT"}],
  url: [scheme: "https", host: "fierce-crag-79985.herokuapp.com", port: 443],
  force_ssl: [rewrite_on: [:x_forwarded_proto]],
  cache_static_manifest: "priv/static/manifest.json",
  secret_key_base: "gpJju8tLSmGOga0uIScZmBtnspYOr7KExygyQFsnQ6BTwX5P3XFUqlud5BmCoOmb"

# Do not print debug messages in production
config :logger, level: :info

# Configure your database
config :fishermans_horizon, FishermansHorizon.Repo,
  adapter: Ecto.Adapters.Postgres,
  hostname: System.get_env("NEW_DATABASE_URL"),
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "18"),
  ssl: true,
  database: System.get_env("DATABASE"),
  username: System.get_env("USERNAME"),
  password: System.get_env("PASSWORD")
