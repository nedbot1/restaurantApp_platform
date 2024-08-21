defmodule RestaurantAppPlatform.TablesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `RestaurantAppPlatform.Tables` context.
  """

  @doc """
  Generate a table.
  """
  def table_fixture(attrs \\ %{}) do
    {:ok, table} =
      attrs
      |> Enum.into(%{
        qr_code: "some qr_code",
        status: "some status",
        table_number: "some table_number"
      })
      |> RestaurantAppPlatform.Tables.create_table()

    table
  end
end
