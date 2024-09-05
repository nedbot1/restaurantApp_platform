defmodule RestaurantAppPlatformWeb.OrderJSON do
  alias RestaurantAppPlatform.Orders.Order

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
      session_id: order.session_id
    }
  end
end
