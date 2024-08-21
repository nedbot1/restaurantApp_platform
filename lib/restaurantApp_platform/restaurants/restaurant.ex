defmodule RestaurantAppPlatform.Restaurants.Restaurant do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "restaurants" do
    field :name, :string
    field :location, :string
    field :contact_number, :string
    belongs_to :account, RestaurantAppPlatform.Accounts.Account
    has_many :tables, RestaurantAppPlatform.Tables.Table
    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(restaurant, attrs) do
    restaurant
    |> cast(attrs, [:name, :location, :contact_number, :account_id])
    |> validate_required([:name, :location, :contact_number, :account_id])
  end
end
