# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

# Configures the endpoint
config :thumber, ThumberWeb.Endpoint,
  #   load_from_system_env: true,
  url: [host: "localhost"],
  render_errors: [view: ThumberWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Thumber.PubSub,
  live_view: [signing_salt: "gzUrpngV"]

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.14.29",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :thumber, :phoenix_swagger,
  swagger_files: %{
    "priv/static/swagger.json" => [
      router: ThumberWeb.Router,
      endpoint: ThumberWeb.Endpoint
    ]
  }

config :phoenix_swagger, json_library: Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
