defmodule RestaurantAppPlatformWeb.MenuControllerTest do
  use RestaurantAppPlatformWeb.ConnCase

  import RestaurantAppPlatform.MenusFixtures

  alias RestaurantAppPlatform.Menus.Menu

  @create_attrs %{
    item_name: "some item_name",
    item_description: "some item_description",
    price: "120.5",
    dish_photo_link: "some dish_photo_link"
  }
  @update_attrs %{
    item_name: "some updated item_name",
    item_description: "some updated item_description",
    price: "456.7",
    dish_photo_link: "some updated dish_photo_link"
  }
  @invalid_attrs %{item_name: nil, item_description: nil, price: nil, dish_photo_link: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all menus", %{conn: conn} do
      conn = get(conn, ~p"/api/menus")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create menu" do
    test "renders menu when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/menus", menu: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/menus/#{id}")

      assert %{
               "id" => ^id,
               "dish_photo_link" => "some dish_photo_link",
               "item_description" => "some item_description",
               "item_name" => "some item_name",
               "price" => "120.5"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/menus", menu: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update menu" do
    setup [:create_menu]

    test "renders menu when data is valid", %{conn: conn, menu: %Menu{id: id} = menu} do
      conn = put(conn, ~p"/api/menus/#{menu}", menu: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/menus/#{id}")

      assert %{
               "id" => ^id,
               "dish_photo_link" => "some updated dish_photo_link",
               "item_description" => "some updated item_description",
               "item_name" => "some updated item_name",
               "price" => "456.7"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, menu: menu} do
      conn = put(conn, ~p"/api/menus/#{menu}", menu: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete menu" do
    setup [:create_menu]

    test "deletes chosen menu", %{conn: conn, menu: menu} do
      conn = delete(conn, ~p"/api/menus/#{menu}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/menus/#{menu}")
      end
    end
  end

  defp create_menu(_) do
    menu = menu_fixture()
    %{menu: menu}
  end
end
