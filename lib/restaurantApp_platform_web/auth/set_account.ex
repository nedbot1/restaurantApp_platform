defmodule RestaurantAppPlatformWeb.Auth.SetAccount do
  import Plug.Conn
  alias RestaurantAppPlatformWeb.Auth.ErrorResponse
  alias RestaurantAppPlatform.Accounts

  def init(_options)do

  end

  def call(conn, _options) do
    if conn.assigns[:account] do
      conn
    else
      case conn.private.guardian_default_claims["sub"] do
        nil -> raise ErrorResponse.Unauthorized
        account_id ->
          account = conn.private.guardian_default_claims["sub"]
          assign(conn, :account, account)
      end
    end
  end
end
