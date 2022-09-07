import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :thumb, ThumbWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "V3sQSmBSUL2b4MeL+Qa8aFlMtpraoPFsRB4DDO29Fz5OhxUdduJRCpBlgtuIG/1T",
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
