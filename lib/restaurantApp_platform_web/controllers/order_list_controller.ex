defmodule RestaurantAppPlatformWeb.OrderListController do
  use RestaurantAppPlatformWeb, :controller

  alias RestaurantAppPlatform.OrderLists
  alias RestaurantAppPlatform.OrderLists.OrderList

  action_fallback RestaurantAppPlatformWeb.FallbackController

  def index(conn, _params) do
    order_lists = OrderLists.list_order_lists()
    render(conn, :index, order_lists: order_lists)
  end

  def create(conn, %{"order_list" => order_list_params}) do
    with {:ok, %OrderList{} = order_list} <- OrderLists.create_order_list(order_list_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/order_lists/#{order_list}")
      |> render(:show, order_list: order_list)
    end
  end

  def show(conn, %{"id" => id}) do
    order_list = OrderLists.get_order_list!(id)
    render(conn, :show, order_list: order_list)
  end

  def update(conn, %{"id" => id, "order_list" => order_list_params}) do
    order_list = OrderLists.get_order_list!(id)

    with {:ok, %OrderList{} = order_list} <- OrderLists.update_order_list(order_list, order_list_params) do
      render(conn, :show, order_list: order_list)
    end
  end

  def delete(conn, %{"id" => id}) do
    order_list = OrderLists.get_order_list!(id)

    with {:ok, %OrderList{}} <- OrderLists.delete_order_list(order_list) do
      send_resp(conn, :no_content, "")
    end
  end
end
