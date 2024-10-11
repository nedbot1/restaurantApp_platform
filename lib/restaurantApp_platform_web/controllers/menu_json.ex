defmodule RestaurantAppPlatformWeb.MenuJSON do
  alias RestaurantAppPlatform.Menus.Menu

  @doc """
  Renders a list of menus grouped by category.
  """

def index(%{menus_by_category: menus_by_category}) do
  # IO.inspect(menus_by_category, label: "Menus by Category in JSON")

  %{
    data: for {category_name, menus} <- menus_by_category do
      %{category_name: category_name, menus: render_menus(menus)}
    end
  }
end


  @doc """
  Renders a single menu.
  """
  def show(%{menu: menu}) do
    # IO.inspect(menu, label: "Menu in Show JSON")
    %{data: data(menu)}
  end

  defp render_menus(menus) do
    for menu <- menus, do: data(menu)
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
      category_name: menu.category && menu.category.name || "No Category"
    }
  end
end
