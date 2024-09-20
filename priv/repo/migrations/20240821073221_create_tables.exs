defmodule RestaurantAppPlatform.Repo.Migrations.CreateTables do
  use Ecto.Migration

  def change do
    create table(:tables, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :table_number, :string
      add :qr_code, :binary
      add :status, :string
      add :restaurant_id, references(:restaurants, on_delete: :nothing, type: :binary_id)

      timestamps(type: :utc_datetime)
    end

    create index(:tables, [:restaurant_id])
  end
end
