defmodule RestaurantAppPlatformWeb.OrderJSON do
  alias RestaurantAppPlatform.Orders.Order
  alias RestaurantAppPlatform.OrderLists.OrderList

  @doc """
  Renders a list of orders.
  """
  def index(%{orders: orders}) do
    %{data: for(order <- orders, do: data(order))}
  end

  @doc """
  Renders a single order.
  """
  def show(%{order: order}) do
    %{data: data(order)}
  end

 defp data(%Order{} = order) do
  %{
    id: order.id,
    ordered_at: order.ordered_at,
    payed_at: order.payed_at,
    total_amount: order.total_amount,
    restaurant_id: order.restaurant_id,
    table_number: order.session.table.table_number,
    order_lists: Enum.map(order.order_lists, &order_list_data/1),
    session_id: order.session_id
  }
end

defp order_list_data(%OrderList{} = order_list) do
  %{
    id: order_list.id,
    quantity: order_list.quantity,
    total_price: order_list.total_price,
    menu_item_id: order_list.menu_item_id,
    item_name: order_list.menu.item_name
  }
end

end
