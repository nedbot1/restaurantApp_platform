defmodule RestaurantAppPlatform.UsersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `RestaurantAppPlatform.Users` context.
  """

  @doc """
  Generate a user.
  """
  # def user_fixture(attrs \\ %{}) do
  #   {:ok, user} =
  #     attrs
  #     |> Enum.into(%{
  #       account_id: "some account_id"
  #     })
  #     |> RestaurantAppPlatform.Users.create_user()

  #   user
  # end

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        full_name: "some full_name",
        role: "some role"
      })
      |> RestaurantAppPlatform.Users.create_user()

    user
  end
end
