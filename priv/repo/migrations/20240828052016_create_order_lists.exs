defmodule RestaurantAppPlatform.Repo.Migrations.CreateOrderLists do
  use Ecto.Migration

  def change do
    create table(:order_lists, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :quantity, :integer
      add :total_price, :decimal
      add :order_id, references(:orders, on_delete: :nothing, type: :binary_id)
      add :menu_item_id, references(:menus, on_delete: :nothing, type: :binary_id)

      timestamps(type: :utc_datetime)
    end

    create index(:order_lists, [:order_id])
    create index(:order_lists, [:menu_item_id])
  end
end
