defmodule RestaurantAppPlatformWeb.MenuController do
  use RestaurantAppPlatformWeb, :controller

  alias RestaurantAppPlatform.Menus
  alias RestaurantAppPlatform.Menus.Menu

  action_fallback RestaurantAppPlatformWeb.FallbackController

  def index(conn, %{"restaurant_id" => restaurant_id}) do
    menus = Menus.get_menus_by_restaurant_id(restaurant_id)
    render(conn, :index, menus: menus)
  end

  def create(conn, %{"menu" => menu_params}) do
    with {:ok, %Menu{} = menu} <- Menus.create_menu(menu_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/menus/#{menu}")
      |> render(:show, menu: menu)
    end
  end



  def show(conn, %{"id" => id}) do
    menu = Menus.get_menu!(id)
    render(conn, :show, menu: menu)
  end

  def update(conn, %{"id" => id, "menu" => menu_params}) do
    menu = Menus.get_menu!(id)

    with {:ok, %Menu{} = menu} <- Menus.update_menu(menu, menu_params) do
      render(conn, :show, menu: menu)
    end
  end

  def delete(conn, %{"id" => id}) do
    menu = Menus.get_menu!(id)

    with {:ok, %Menu{}} <- Menus.delete_menu(menu) do
      send_resp(conn, :no_content, "")
    end
  end

def create_batch(conn, %{"menus" => menus_params}) do
  created_menus = Menus.create_menus(menus_params)

  case Enum.all?(created_menus, &match?({:ok, _}, &1)) do
    true ->
      menus = Enum.map(created_menus, fn {:ok, menu} -> menu end)
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/menus")
      |> render(:index, menus: menus)
    false ->
      conn
      |> put_status(:unprocessable_entity)
      |> render(:error, message: "Failed to create some menus")
  end
end


  # Helper function to format menu data
  defp format_menu(menu) do
    %{
      id: menu.id,
      item_name: menu.item_name,
      item_description: menu.item_description,
      price: Decimal.to_string(menu.price), # Ensure price is a string if sending as JSON
      dish_photo_link: menu.dish_photo_link
    }
  end


end
