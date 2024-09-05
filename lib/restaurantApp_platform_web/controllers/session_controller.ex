defmodule RestaurantAppPlatformWeb.SessionController do
  use RestaurantAppPlatformWeb, :controller

  alias RestaurantAppPlatform.Sessions
  alias RestaurantAppPlatform.Sessions.Session

  action_fallback RestaurantAppPlatformWeb.FallbackController

  def index(conn, _params) do
    sessions = Sessions.list_sessions()
    render(conn, :index, sessions: sessions)
  end

  def create(conn, %{"session" => session_params}) do
    with {:ok, %Session{} = session} <- Sessions.create_session(session_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/sessions/#{session}")
      |> render(:show, session: session)
    end
  end

  # def end_session(conn, %{"id" => session_id}) do
  #   case Sessions.end_session(session_id) do
  #     {:ok, session} ->
  #       conn
  #       |> put_status(:ok)
  #       |> json(%{message: "Session ended successfully", session: session})
  #     {:error, reason} ->
  #       conn
  #       |> put_status(:bad_request)
  #       |> json(%{error: reason})
  #   end
  # end

  def end_session(conn, %{"id" => session_id}) do
  case Sessions.end_session(session_id) do
    {:ok, session} ->
      conn
      |> put_status(:ok)
      |> render("show.json", session: session)
    {:error, reason} ->
      conn
      |> put_status(:bad_request)
      |> render("error.json", error: reason)
  end
end

  def show(conn, %{"id" => id}) do
    session = Sessions.get_session!(id)
    render(conn, :show, session: session)
  end

  def update(conn, %{"id" => id, "session" => session_params}) do
    session = Sessions.get_session!(id)

    with {:ok, %Session{} = session} <- Sessions.update_session(session, session_params) do
      render(conn, :show, session: session)
    end
  end

  def delete(conn, %{"id" => id}) do
    session = Sessions.get_session!(id)

    with {:ok, %Session{}} <- Sessions.delete_session(session) do
      send_resp(conn, :no_content, "")
    end
  end
end
