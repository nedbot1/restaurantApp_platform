defmodule RestaurantAppPlatform.Repo do
  use Ecto.Repo,
    otp_app: :restaurantApp_platform,
    adapter: Ecto.Adapters.Postgres
end
