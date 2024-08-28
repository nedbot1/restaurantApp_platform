defmodule RestaurantAppPlatform.OrderLists do
  @moduledoc """
  The OrderLists context.
  """

  import Ecto.Query, warn: false
  alias RestaurantAppPlatform.Repo

  alias RestaurantAppPlatform.OrderLists.OrderList

  @doc """
  Returns the list of order_lists.

  ## Examples

      iex> list_order_lists()
      [%OrderList{}, ...]

  """
  def list_order_lists do
    Repo.all(OrderList)
  end

  @doc """
  Gets a single order_list.

  Raises `Ecto.NoResultsError` if the Order list does not exist.

  ## Examples

      iex> get_order_list!(123)
      %OrderList{}

      iex> get_order_list!(456)
      ** (Ecto.NoResultsError)

  """
  def get_order_list!(id), do: Repo.get!(OrderList, id)

  @doc """
  Creates a order_list.

  ## Examples

      iex> create_order_list(%{field: value})
      {:ok, %OrderList{}}

      iex> create_order_list(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_order_list(attrs \\ %{}) do
    %OrderList{}
    |> OrderList.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a order_list.

  ## Examples

      iex> update_order_list(order_list, %{field: new_value})
      {:ok, %OrderList{}}

      iex> update_order_list(order_list, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_order_list(%OrderList{} = order_list, attrs) do
    order_list
    |> OrderList.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a order_list.

  ## Examples

      iex> delete_order_list(order_list)
      {:ok, %OrderList{}}

      iex> delete_order_list(order_list)
      {:error, %Ecto.Changeset{}}

  """
  def delete_order_list(%OrderList{} = order_list) do
    Repo.delete(order_list)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking order_list changes.

  ## Examples

      iex> change_order_list(order_list)
      %Ecto.Changeset{data: %OrderList{}}

  """
  def change_order_list(%OrderList{} = order_list, attrs \\ %{}) do
    OrderList.changeset(order_list, attrs)
  end
end
