defmodule RestaurantAppPlatformWeb.Auth.ErrorResponse.Unauthorized do
  defexception [message: "unauthorized", plug_status: 401]
end
