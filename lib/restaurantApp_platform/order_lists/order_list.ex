defmodule RestaurantAppPlatform.OrderLists.OrderList do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "order_lists" do
    field :quantity, :integer
    field :total_price, :decimal
    belongs_to :order, RestaurantAppPlatform.Orders.Order
    belongs_to :menu, RestaurantAppPlatform.Menus.Menu, foreign_key: :menu_item_id, type: :binary_id
    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(order_list, attrs) do
    order_list
    |> cast(attrs, [:order_id, :menu_item_id, :quantity, :total_price])
    |> validate_required([:order_id, :menu_item_id, :quantity, :total_price])
  end
end
