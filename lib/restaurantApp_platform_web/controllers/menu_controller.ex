defmodule RestaurantAppPlatformWeb.MenuController do
  use RestaurantAppPlatformWeb, :controller

  alias RestaurantAppPlatform.Menus
  alias RestaurantAppPlatform.Menus.Menu

  action_fallback RestaurantAppPlatformWeb.FallbackController

  def index(conn, _params) do
    menus = Menus.list_menus()
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

  def create_batch(conn, %{"menus" => menus_params}) do
  created_menus = Menus.create_menus(menus_params)

  case Enum.all?(created_menus, &match?({:ok, _}, &1)) do
    true ->
      menus = Enum.map(created_menus, fn {:ok, table} -> table end)
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
end
