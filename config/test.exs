import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :thumber, ThumberWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "V8xfda92Wr0PlQQspZwmcRoUHAxV06Suhx9plkL4t+hbR5GmD471GOCx9Qh1RfOG",
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
