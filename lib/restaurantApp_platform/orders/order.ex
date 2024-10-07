defmodule RestaurantAppPlatform.Orders.Order do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:id, :ordered_at, :payed_at, :total_amount, :session_id, :restaurant_id]}
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "orders" do
    field :ordered_at, :utc_datetime
    field :payed_at, :utc_datetime
    field :total_amount, :decimal
    belongs_to :session, RestaurantAppPlatform.Sessions.Session
    belongs_to :restaurant,RestaurantAppPlatform.Restaurants.Restaurant
    has_many :order_lists, RestaurantAppPlatform.OrderLists.OrderList
    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(order, attrs) do
    now = DateTime.utc_now() |> DateTime.truncate(:second)

    order
    |> cast(attrs, [:session_id, :payed_at, :total_amount, :restaurant_id])
    |> put_change(:ordered_at, now) # Automatically set ordered_at with truncated microseconds
    |> validate_required([:session_id, :total_amount, :restaurant_id])
  end
end
