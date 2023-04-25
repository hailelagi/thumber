# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :thumber,
  ecto_repos: [Thumber.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :thumber, ThumberWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: ThumberWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Thumber.PubSub,
  live_view: [signing_salt: "3KUuCZ/c"]

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.14.0",
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

config :ueberauth, Ueberauth,
  providers: [
    github:
      {Ueberauth.Strategy.Github,
       [default_scope: "user", allow_private_emails: true, send_redirect_uri: false]}
  ]

config :ueberauth, Ueberauth.Strategy.Github.OAuth,
  client_id: System.get_env("GITHUB_CLIENT_ID"),
  client_secret: System.get_env("GITHUB_CLIENT_SECRET")

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
