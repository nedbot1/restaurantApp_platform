defmodule RestaurantAppPlatform.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `RestaurantAppPlatform.Accounts` context.
  """

  @doc """
  Generate a unique account email.
  """
  def unique_account_email, do: "some email#{System.unique_integer([:positive])}"

  @doc """
  Generate a account.
  """
  def account_fixture(attrs \\ %{}) do
    {:ok, account} =
      attrs
      |> Enum.into(%{
        email: unique_account_email(),
        owner_name: "some owner_name",
        password_hash: "some password_hash",
        phone_number: "some phone_number",
        salt: "some salt",
        suscribed_at: ~U[2024-08-20 04:32:00Z]
      })
      |> RestaurantAppPlatform.Accounts.create_account()

    account
  end
end
