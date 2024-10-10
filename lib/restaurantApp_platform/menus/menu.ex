defmodule RestaurantAppPlatform.Menus.Menu do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "menus" do
    field :item_name, :string
    field :item_description, :string
    field :price, :decimal
    field :dish_photo_link, :string
    belongs_to :restaurant, RestaurantAppPlatform.Restaurants.Restaurant
    belongs_to :category, RestaurantAppPlatform.Categories.Category
    # has_many :order_lists, RestaurantAppPlatform.OrderLists.OrderList
    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(menu, attrs) do
    menu
    |> cast(attrs, [:item_name, :item_description, :price, :dish_photo_link, :restaurant_id, :category_id])
    |> validate_required([:item_name, :item_description, :price, :dish_photo_link, :restaurant_id, :category_id])
  end
end
