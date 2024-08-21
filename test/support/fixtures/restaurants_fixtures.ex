defmodule RestaurantAppPlatform.RestaurantsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `RestaurantAppPlatform.Restaurants` context.
  """

  @doc """
  Generate a restaurant.
  """
  def restaurant_fixture(attrs \\ %{}) do
    {:ok, restaurant} =
      attrs
      |> Enum.into(%{
        contact_number: "some contact_number",
        location: "some location",
        name: "some name"
      })
      |> RestaurantAppPlatform.Restaurants.create_restaurant()

    restaurant
  end
end
