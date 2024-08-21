defmodule RestaurantAppPlatform.Repo.Migrations.CreateRestaurants do
  use Ecto.Migration

  def change do
    create table(:restaurants, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :location, :string
      add :contact_number, :string
      add :account_id, references(:accounts, on_delete: :nothing, type: :binary_id)

      timestamps(type: :utc_datetime)
    end

    create index(:restaurants, [:account_id])
  end
end
