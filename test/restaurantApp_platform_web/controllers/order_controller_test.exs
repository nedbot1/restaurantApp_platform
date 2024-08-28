defmodule RestaurantAppPlatformWeb.OrderControllerTest do
  use RestaurantAppPlatformWeb.ConnCase

  import RestaurantAppPlatform.OrdersFixtures

  alias RestaurantAppPlatform.Orders.Order

  @create_attrs %{
    ordered_at: ~U[2024-08-27 05:10:00Z],
    payed_at: ~U[2024-08-27 05:10:00Z],
    total_amount: "120.5"
  }
  @update_attrs %{
    ordered_at: ~U[2024-08-28 05:10:00Z],
    payed_at: ~U[2024-08-28 05:10:00Z],
    total_amount: "456.7"
  }
  @invalid_attrs %{ordered_at: nil, payed_at: nil, total_amount: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all orders", %{conn: conn} do
      conn = get(conn, ~p"/api/orders")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create order" do
    test "renders order when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/orders", order: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/orders/#{id}")

      assert %{
               "id" => ^id,
               "ordered_at" => "2024-08-27T05:10:00Z",
               "payed_at" => "2024-08-27T05:10:00Z",
               "total_amount" => "120.5"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/orders", order: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update order" do
    setup [:create_order]

    test "renders order when data is valid", %{conn: conn, order: %Order{id: id} = order} do
      conn = put(conn, ~p"/api/orders/#{order}", order: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/orders/#{id}")

      assert %{
               "id" => ^id,
               "ordered_at" => "2024-08-28T05:10:00Z",
               "payed_at" => "2024-08-28T05:10:00Z",
               "total_amount" => "456.7"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, order: order} do
      conn = put(conn, ~p"/api/orders/#{order}", order: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete order" do
    setup [:create_order]

    test "deletes chosen order", %{conn: conn, order: order} do
      conn = delete(conn, ~p"/api/orders/#{order}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/orders/#{order}")
      end
    end
  end

  defp create_order(_) do
    order = order_fixture()
    %{order: order}
  end
end
