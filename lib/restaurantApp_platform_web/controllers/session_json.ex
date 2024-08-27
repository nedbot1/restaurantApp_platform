defmodule RestaurantAppPlatformWeb.SessionJSON do
  alias RestaurantAppPlatform.Sessions.Session

  @doc """
  Renders a list of sessions.
  """
  def index(%{sessions: sessions}) do
    %{data: for(session <- sessions, do: data(session))}
  end

  @doc """
  Renders a single session.
  """
  def show(%{session: session}) do
    %{data: data(session)}
  end

  defp data(%Session{} = session) do
    %{
      id: session.id,
      session_token: session.session_token,
      start_time: session.start_time,
      end_time: session.end_time
    }
  end
end
