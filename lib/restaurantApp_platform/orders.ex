defmodule RestaurantAppPlatform.Orders do
  @moduledoc """
  The Orders context.
  """

  import Ecto.Query, warn: false
  alias RestaurantAppPlatform.Repo
  alias RestaurantAppPlatform.Sessions.Session
  alias RestaurantAppPlatform.Orders.Order
  alias RestaurantAppPlatform.OrderLists.OrderList
  @doc """
  Returns the list of orders.

  ## Examples

      iex> list_orders()
      [%Order{}, ...]

  """
  def list_orders do
    Repo.all(Order)
  end

  @doc """
  Gets a single order.

  Raises `Ecto.NoResultsError` if the Order does not exist.

  ## Examples

      iex> get_order!(123)
      %Order{}

      iex> get_order!(456)
      ** (Ecto.NoResultsError)

  """
  def get_order!(id), do: Repo.get!(Order, id)

  @doc """
  Creates a order.

  ## Examples

      iex> create_order(%{field: value})
      {:ok, %Order{}}

      iex> create_order(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_order(attrs \\ %{}) do
    %Order{}
    |> Order.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a order.

  ## Examples

      iex> update_order(order, %{field: new_value})
      {:ok, %Order{}}

      iex> update_order(order, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_order(%Order{} = order, attrs) do
    order
    |> Order.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a order.

  ## Examples

      iex> delete_order(order)
      {:ok, %Order{}}

      iex> delete_order(order)
      {:error, %Ecto.Changeset{}}

  """
  def delete_order(%Order{} = order) do
    Repo.delete(order)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking order changes.

  ## Examples

      iex> change_order(order)
      %Ecto.Changeset{data: %Order{}}

  """
  def change_order(%Order{} = order, attrs \\ %{}) do
    Order.changeset(order, attrs)
  end

#   def create_order_with_items(attrs \\ %{}) do
#   Repo.transaction(fn ->
#     # Create the order first
#     order_changeset = Order.changeset(%Order{}, attrs.order)
#     {:ok, order} = Repo.insert(order_changeset)

#     # Loop through the items and create order_list entries
#     Enum.each(attrs.items, fn item ->
#       order_list_attrs = %{
#         order_id: order.id,
#         menu_item_id: item.menu_item_id,
#         quantity: item.quantity,
#         total_price: item.total_price
#       }

#       order_list_changeset = OrderList.changeset(%OrderList{}, order_list_attrs)
#       Repo.insert!(order_list_changeset)
#     end)

#     order
#   end)
# end

# def create_order_with_items(%{"order" => order_attrs}) do
#   Repo.transaction(fn ->
#     # Extract session_id and total_amount from the order attributes
#     order_data = %{
#       session_id: order_attrs["session_id"],
#       total_amount: order_attrs["total_amount"]
#     }

#     # Create the order first
#     order_changeset = Order.changeset(%Order{}, order_data)
#     {:ok, order} = Repo.insert(order_changeset)

#     # Loop through the items and create order_list entries
#     Enum.each(order_attrs["order_lists"], fn item ->
#       order_list_attrs = %{
#         order_id: order.id,
#         menu_item_id: item["menu_item_id"],
#         quantity: item["quantity"],
#         total_price: item["total_price"]
#       }

#       order_list_changeset = OrderList.changeset(%OrderList{}, order_list_attrs)
#       Repo.insert!(order_list_changeset)
#     end)
#     order
#   end)
# end

def create_order_with_items(%{"order" => order_attrs}) do
  Repo.transaction(fn ->
    # Ensure you're referring to the correct Session module
    session = Repo.get!(Session, order_attrs["session_id"])
    current_time = DateTime.utc_now()

    # Check if the session has expired
    if DateTime.compare(current_time, session.end_time) == :gt do
      # Rollback the transaction and return an error message
      Repo.rollback(:session_timeout)
    else
      # Proceed with order creation as before
      order_data = %{
        session_id: order_attrs["session_id"],
        total_amount: order_attrs["total_amount"]
      }

      order_changeset = Order.changeset(%Order{}, order_data)
      {:ok, order} = Repo.insert(order_changeset)

      # Create order_list entries
      Enum.each(order_attrs["order_lists"], fn item ->
        order_list_attrs = %{
          order_id: order.id,
          menu_item_id: item["menu_item_id"],
          quantity: item["quantity"],
          total_price: item["total_price"]
        }

        order_list_changeset = OrderList.changeset(%OrderList{}, order_list_attrs)
        Repo.insert!(order_list_changeset)
      end)

      order
    end
  end)
end



end
