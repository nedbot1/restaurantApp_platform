defmodule RestaurantAppPlatform.Tables.Table do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "tables" do
    field :status, :string, default: "available"
    field :table_number, :string
    field :qr_code, :string
    belongs_to :restaurant, RestaurantAppPlatform.Restaurants.Restaurant
    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(table, attrs) do
    table
    |> cast(attrs, [:table_number, :qr_code, :status, :restaurant_id])
    |> validate_required([:table_number, :qr_code, :status, :restaurant_id])
  end
end
