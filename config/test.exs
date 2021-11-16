import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :fishermans_horizon, FishermansHorizon.Repo,
  username: "postgres",
  password: "postgres",
  database: "fishermans_horizon_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :fishermans_horizon, FishermansHorizonWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "4Qnvu/357sxK1SIdNxSkwdxvSV4cm2NELvQzDjUq89TvHz4Q9N5Vw60yAiA0yQTH",
  server: false

# In test we don't send emails.
config :fishermans_horizon, FishermansHorizon.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
