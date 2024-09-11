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
  Order
  |> Repo.all()
  |> Repo.preload([order_lists: :menu, session: :table])
end


def list_unpaid_orders do
  Order
  |> where([o], is_nil(o.payed_at))
  |> Repo.all()
  |> Repo.preload([order_lists: :menu, session: :table]) # Preload session and table if needed
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
  def get_order!(id) do
  Order
  |> Repo.get!(id)
  |> Repo.preload([order_lists: :menu, session: :table])
end


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

def create_order_with_items(%{"order" => order_attrs}) do
  Repo.transaction(fn ->
    session = Repo.get!(Session, order_attrs["session_id"])
    current_time = DateTime.utc_now()

    if DateTime.compare(current_time, session.end_time) == :gt do
      Repo.rollback(:session_timeout)
    else
      order_data = %{
        session_id: order_attrs["session_id"],
        total_amount: order_attrs["total_amount"]
      }

      order_changeset = Order.changeset(%Order{}, order_data)
      {:ok, order} = Repo.insert(order_changeset)

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

      # Ensure the order_lists are preloaded
      Repo.preload(order,[order_lists: :menu, session: :table])
    end
  end)
end




end
