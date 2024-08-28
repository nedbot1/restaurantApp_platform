defmodule RestaurantAppPlatformWeb.OrderListJSON do
  alias RestaurantAppPlatform.OrderLists.OrderList

  @doc """
  Renders a list of order_lists.
  """
  def index(%{order_lists: order_lists}) do
    %{data: for(order_list <- order_lists, do: data(order_list))}
  end

  @doc """
  Renders a single order_list.
  """
  def show(%{order_list: order_list}) do
    %{data: data(order_list)}
  end

  defp data(%OrderList{} = order_list) do
    %{
      id: order_list.id,
      quantity: order_list.quantity,
      total_price: order_list.total_price
    }
  end
end
