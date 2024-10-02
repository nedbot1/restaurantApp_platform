defmodule RestaurantAppPlatform.Repo.Migrations.AddRestaurantIdToOrders do
  use Ecto.Migration

  def change do
      alter table(:orders) do
        add :restaurant_id, references(:restaurants, type: :binary_id, on_delete: :nothing)
      end
        # Optionally, you may add an index for faster lookups
    create index(:orders, [:restaurant_id])
  end
end
