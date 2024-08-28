defmodule RestaurantAppPlatform.Repo.Migrations.CreateOrders do
  use Ecto.Migration

  def change do
    create table(:orders, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :ordered_at, :utc_datetime
      add :payed_at, :utc_datetime
      add :total_amount, :decimal
      add :session_id, references(:sessions, on_delete: :nothing, type: :binary_id)

      timestamps(type: :utc_datetime)
    end

    create index(:orders, [:session_id])
  end
end
