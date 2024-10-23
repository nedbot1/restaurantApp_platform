defmodule RestaurantAppPlatformWeb.Auth.ErrorResponse do
  defmodule Unauthorized do
    defexception [message: "unauthorized", plug_status: 401]
  end

  defmodule Forbidden do
    defexception [message: "you don't have access to this resource", plug_status: 403]
  end

  defmodule NotFound do
    defexception [message: "resource not found", plug_status: 404]
  end

end
