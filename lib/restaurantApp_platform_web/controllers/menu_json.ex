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
      restaurant_id: menu.restaurant_id
    }
  end
end
