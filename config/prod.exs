import Config

# Configures Swoosh API Client
config :swoosh, api_client: Swoosh.ApiClient.Finch, finch_name: RestaurantAppPlatform.Finch

# Disable Swoosh Local Memory Storage
config :swoosh, local: false

# Do not print debug messages in production
config :logger, level: :info

# Runtime production configuration, including reading
# of environment variables, is done on config/runtime.exs.
config :restaurantApp_platform, RestaurantAppPlatform.Endpoint,
  http: [port: {:system, "PORT"}],
  server: true,
  url: [host: "your-app.onrender.com", port: 80]

config :restaurantApp_platform, RestaurantAppPlatform.Repo,
  url: {:system, "DATABASE_URL"},
  pool_size: 15
