defmodule RestaurantAppPlatform.Repo.Migrations.CreateMenus do
  use Ecto.Migration

  def change do
    create table(:menus, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :item_name, :string
      add :item_description, :text
      add :price, :decimal
      add :dish_photo_link, :string
      add :restaurant_id, references(:restaurants, on_delete: :nothing, type: :binary_id)

      timestamps(type: :utc_datetime)
    end

    create index(:menus, [:restaurant_id])
  end
end
