defmodule RestaurantAppPlatformWeb.MenuJSON do
  alias RestaurantAppPlatform.Menus.Menu

  @doc """
  Renders a list of menus.
  """
  def index(%{menus: menus}) do
    %{data: for(menu <- menus, do: data(menu))}
  end

  @doc """
  Renders a single menu.
  """
  def show(%{menu: menu}) do
    %{data: data(menu)}
  end

  defp data(%Menu{} = menu) do
    %{
      id: menu.id,
      item_name: menu.item_name,
      item_description: menu.item_description,
      price: menu.price,
      dish_photo_link: menu.dish_photo_link,
      restaurant_id: menu.restaurant_id,
      category_id: menu.category_id,
      category_name: get_category_name(menu)  # Use a helper function to safely access category name
    }
  end

  defp get_category_name(%Menu{category: nil}), do: "No Category"
  defp get_category_name(%Menu{category: category}), do: category.name
end
