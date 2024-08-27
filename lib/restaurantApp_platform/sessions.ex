defmodule RestaurantAppPlatform.Sessions do
  @moduledoc """
  The Sessions context.
  """
  # import Ecto.Changeset
  import Ecto.Query, warn: false
  alias RestaurantAppPlatform.Repo

  alias RestaurantAppPlatform.Sessions.Session

  @doc """
  Returns the list of sessions.

  ## Examples

      iex> list_sessions()
      [%Session{}, ...]

  """
  def list_sessions do
    Repo.all(Session)
  end

  @doc """
  Gets a single session.

  Raises `Ecto.NoResultsError` if the Session does not exist.

  ## Examples

      iex> get_session!(123)
      %Session{}

      iex> get_session!(456)
      ** (Ecto.NoResultsError)

  """
  def get_session!(id), do: Repo.get!(Session, id)

  @doc """
  Creates a session.

  ## Examples

      iex> create_session(%{field: value})
      {:ok, %Session{}}

      iex> create_session(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """

def create_session(attrs \\ %{}) do
  start_time = DateTime.utc_now()
  end_time = DateTime.add(start_time, 3600, :second)  # Add 1 minute (60 seconds) to start_time

  session_attrs = Map.merge(attrs, %{
    "start_time" => start_time,
    "end_time" => end_time,
    "session_token" => generate_token()
  })

  %Session{}
  |> Session.changeset(session_attrs)
  |> Repo.insert()
end


  defp generate_token do
  :crypto.strong_rand_bytes(16)
  |> Base.encode64()
  |> binary_part(0, 16)
end



  @doc """
  Updates a session.

  ## Examples

      iex> update_session(session, %{field: new_value})
      {:ok, %Session{}}

      iex> update_session(session, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_session(%Session{} = session, attrs) do
    session
    |> Session.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a session.

  ## Examples

      iex> delete_session(session)
      {:ok, %Session{}}

      iex> delete_session(session)
      {:error, %Ecto.Changeset{}}

  """
  def delete_session(%Session{} = session) do
    Repo.delete(session)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking session changes.

  ## Examples

      iex> change_session(session)
      %Ecto.Changeset{data: %Session{}}

  """
  def change_session(%Session{} = session, attrs \\ %{}) do
    Session.changeset(session, attrs)
  end
end
