defmodule RestaurantAppPlatform.SessionsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `RestaurantAppPlatform.Sessions` context.
  """

  @doc """
  Generate a session.
  """
  # def session_fixture(attrs \\ %{}) do
  #   {:ok, session} =
  #     attrs
  #     |> Enum.into(%{
  #       session_token: "some session_token"
  #     })
  #     |> RestaurantAppPlatform.Sessions.create_session()

  #   session
  # end

  @doc """
  Generate a session.
  """
  def session_fixture(attrs \\ %{}) do
    {:ok, session} =
      attrs
      |> Enum.into(%{
        end_time: ~U[2024-08-26 05:31:00Z],
        session_token: "some session_token",
        start_time: ~U[2024-08-26 05:31:00Z]
      })
      |> RestaurantAppPlatform.Sessions.create_session()

    session
  end
end
