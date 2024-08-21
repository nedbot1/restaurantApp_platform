defmodule RestaurantAppPlatform.MenusFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `RestaurantAppPlatform.Menus` context.
  """

  @doc """
  Generate a menu.
  """
  def menu_fixture(attrs \\ %{}) do
    {:ok, menu} =
      attrs
      |> Enum.into(%{
        dish_photo_link: "some dish_photo_link",
        item_description: "some item_description",
        item_name: "some item_name",
        price: "120.5"
      })
      |> RestaurantAppPlatform.Menus.create_menu()

    menu
  end
end
