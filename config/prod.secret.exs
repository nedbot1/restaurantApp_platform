import Config

database_url = System.get_env("DATABASE_URL")
# Configure your database
config :restaurantApp_platform, RestaurantAppPlatform.Repo,
url: database_url,
  pool_size: 20
