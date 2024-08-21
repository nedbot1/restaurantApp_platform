defmodule RestaurantAppPlatform.Repo.Migrations.CreateAccounts do
  use Ecto.Migration

  def change do
    create table(:accounts, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :owner_name, :string
      add :email, :string
      add :password_hash, :string
      add :salt, :string
      add :phone_number, :string
      add :suscribed_at, :utc_datetime

      timestamps(type: :utc_datetime)
    end

    create unique_index(:accounts, [:email])
  end
end
