defmodule RestaurantAppPlatform.OrderListsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `RestaurantAppPlatform.OrderLists` context.
  """

  @doc """
  Generate a order_list.
  """
  def order_list_fixture(attrs \\ %{}) do
    {:ok, order_list} =
      attrs
      |> Enum.into(%{
        quantity: 42,
        total_price: "120.5"
      })
      |> RestaurantAppPlatform.OrderLists.create_order_list()

    order_list
  end
end
