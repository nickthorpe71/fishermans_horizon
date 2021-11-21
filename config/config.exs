# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :phoenix, :json_library, Jason
config :esbuild, :version, "0.13.10"

config :fishermans_horizon, FishermansHorizon.Repo,
  adapter: Ecto.Adapters.Postgres,
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "18"),
  # ssl: true,
  url: System.get_env("DATABASE_URL")

# Configures the endpoint
config :fishermans_horizon, FishermansHorizonWeb.Endpoint,
  load_from_system_env: true,
  url: [scheme: "https", host: "fierce-crag-79985.herokuapp.com", port: 443],
  # force_ssl: [rewrite_on: [:x_forwarded_proto]],
  cache_static_manifest: "priv/static/cache_manifest.json",
  secret_key_base: "gpJju8tLSmGOga0uIScZmBtnspYOr7KExygyQFsnQ6BTwX5P3XFUqlud5BmCoOmb",
  live_view: [signing_salt: "FrmZUFBVLcb9LABi"],
  pubsub_server: FishermansHorizon.PubSub

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
# config :fishermans_horizon, FishermansHorizon.Mailer, adapter: Swoosh.Adapters.Local

# Swoosh API client is needed for adapters other than SMTP.
# config :swoosh, :api_client, false

# Configure esbuild (the version is required)
# config :esbuild,
#   version: "0.12.18",
#   default: [
#     args:
#       ~w(js/app.js --bundle --target=es2016 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
#     cd: Path.expand("../assets", __DIR__),
#     env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
#   ]

# Configures Elixir's Logger
config :logger, level: :info

# Use Jason for JSON parsing in Phoenix
# config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
