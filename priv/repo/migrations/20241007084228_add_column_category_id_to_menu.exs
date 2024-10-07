defmodule RestaurantAppPlatform.Repo.Migrations.AddColumnCategoryIdToMenu do
  use Ecto.Migration

  def change do
    alter table(:menus) do
        add :category_id, references(:categories, type: :binary_id, on_delete: :nothing)
    end
     create index(:menus, [:category_id])
  end
end
