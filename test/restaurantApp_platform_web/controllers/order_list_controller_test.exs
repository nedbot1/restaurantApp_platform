defmodule RestaurantAppPlatformWeb.OrderListControllerTest do
  use RestaurantAppPlatformWeb.ConnCase

  import RestaurantAppPlatform.OrderListsFixtures

  alias RestaurantAppPlatform.OrderLists.OrderList

  @create_attrs %{
    quantity: 42,
    total_price: "120.5"
  }
  @update_attrs %{
    quantity: 43,
    total_price: "456.7"
  }
  @invalid_attrs %{quantity: nil, total_price: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all order_lists", %{conn: conn} do
      conn = get(conn, ~p"/api/order_lists")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create order_list" do
    test "renders order_list when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/order_lists", order_list: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/order_lists/#{id}")

      assert %{
               "id" => ^id,
               "quantity" => 42,
               "total_price" => "120.5"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/order_lists", order_list: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update order_list" do
    setup [:create_order_list]

    test "renders order_list when data is valid", %{conn: conn, order_list: %OrderList{id: id} = order_list} do
      conn = put(conn, ~p"/api/order_lists/#{order_list}", order_list: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/order_lists/#{id}")

      assert %{
               "id" => ^id,
               "quantity" => 43,
               "total_price" => "456.7"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, order_list: order_list} do
      conn = put(conn, ~p"/api/order_lists/#{order_list}", order_list: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete order_list" do
    setup [:create_order_list]

    test "deletes chosen order_list", %{conn: conn, order_list: order_list} do
      conn = delete(conn, ~p"/api/order_lists/#{order_list}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/order_lists/#{order_list}")
      end
    end
  end

  defp create_order_list(_) do
    order_list = order_list_fixture()
    %{order_list: order_list}
  end
end
