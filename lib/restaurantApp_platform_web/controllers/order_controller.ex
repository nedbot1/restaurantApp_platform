defmodule RestaurantAppPlatformWeb.OrderController do
  use RestaurantAppPlatformWeb, :controller

  alias RestaurantAppPlatform.Orders
  alias RestaurantAppPlatform.Orders.Order

  action_fallback RestaurantAppPlatformWeb.FallbackController

  def index(conn, _params) do
    orders = Orders.list_orders()
    render(conn, :index, orders: orders)
  end

  # def create(conn, %{"order" => order_params}) do
  #   with {:ok, %Order{} = order} <- Orders.create_order(order_params) do
  #     conn
  #     |> put_status(:created)
  #     |> put_resp_header("location", ~p"/api/orders/#{order}")
  #     |> render(:show, order: order)
  #   end
  # end


def create(conn, %{"order" => order_params}) do
  with {:ok, order} <- Orders.create_order_with_items(%{"order" => order_params}) do
    conn
    |> put_status(:created)
    |> put_resp_header("location", ~p"/api/orders/#{order}")
    |> render("show.json", order: order)
  end
end



  def show(conn, %{"id" => id}) do
    order = Orders.get_order!(id)
    render(conn, :show, order: order)
  end

  def update(conn, %{"id" => id, "order" => order_params}) do
    order = Orders.get_order!(id)

    with {:ok, %Order{} = order} <- Orders.update_order(order, order_params) do
      render(conn, :show, order: order)
    end
  end

  def delete(conn, %{"id" => id}) do
    order = Orders.get_order!(id)

    with {:ok, %Order{}} <- Orders.delete_order(order) do
      send_resp(conn, :no_content, "")
    end
  end
end
