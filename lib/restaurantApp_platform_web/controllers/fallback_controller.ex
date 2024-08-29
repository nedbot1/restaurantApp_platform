defmodule RestaurantAppPlatformWeb.FallbackController do
  use RestaurantAppPlatformWeb, :controller

  # Handle Ecto's insert/update/delete errors with a changeset
  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(RestaurantAppPlatformWeb.ChangesetJSON)
    |> render(:error, changeset: changeset)
  end

  # Handle not found errors
  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(html: RestaurantAppPlatformWeb.ErrorHTML, json: RestaurantAppPlatformWeb.ErrorJSON)
    |> render(:"404")
  end

  def call(conn, {:error, :session_timeout}) do
  conn
  |> put_status(:unauthorized)
  |> json(%{error: "Session has timed out. Please start a new session to continue."})
end

  # Generic internal server error handler
  def call(conn, {:error, _reason}) do
    conn
    |> put_status(:internal_server_error)
    |> put_view(json: RestaurantAppPlatformWeb.ErrorJSON)
    |> render(:"500")
  end
end
