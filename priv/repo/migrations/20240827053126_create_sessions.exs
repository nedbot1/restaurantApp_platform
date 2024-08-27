defmodule RestaurantAppPlatform.Repo.Migrations.CreateSessions do
  use Ecto.Migration

  def change do
    create table(:sessions, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :session_token, :string
      add :start_time, :utc_datetime
      add :end_time, :utc_datetime
      add :table_id, references(:tables, on_delete: :nothing, type: :binary_id)

      timestamps(type: :utc_datetime)
    end

    create index(:sessions, [:table_id])
  end
end
