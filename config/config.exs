# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :restaurantApp_platform,
  ecto_repos: [RestaurantAppPlatform.Repo],
  generators: [timestamp_type: :utc_datetime, binary_id: true]

# Configures the endpoint
config :restaurantApp_platform, RestaurantAppPlatformWeb.Endpoint,
  url: [host: System.get_env("API_URL")],
  adapter: Bandit.PhoenixAdapter,
  render_errors: [
    formats: [json: RestaurantAppPlatformWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: RestaurantAppPlatform.PubSub,
  live_view: [signing_salt: "14LsngXb"]

# Add this to allow CORS and the ngrok header
# config :cors_plug,
#   origins: [System.get_env("BASE_URL")],
#   methods: ["GET", "POST", "PUT", "DELETE", "OPTIONS"],
#   headers: ["ngrok-skip-browser-warning", "authorization", "content-type", "accept"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :restaurantApp_platform, RestaurantAppPlatform.Mailer, adapter: Swoosh.Adapters.Local

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
