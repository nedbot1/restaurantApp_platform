defmodule RestaurantAppPlatformWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline,  otp_app: :restaurantApp_platform,
  module: RestaurantAppPlatformWeb.Auth.Guardian,
  error_handler: RestaurantAppPlatformWeb.Auth.GuardianErrorHandler

  plug Guardian.Plug.VerifySession
  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource

end
