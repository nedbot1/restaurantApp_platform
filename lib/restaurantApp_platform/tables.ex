defmodule RestaurantAppPlatform.Tables do
  @moduledoc """
  The Tables context.
  """

  import Ecto.Query, warn: false
  alias RestaurantAppPlatform.Repo

  alias RestaurantAppPlatform.Tables.Table

  @doc """
  Returns the list of tables.

  ## Examples

      iex> list_tables()
      [%Table{}, ...]

  """
  def list_tables do
    Repo.all(Table)
  end

  @doc """
  Gets a single table.

  Raises `Ecto.NoResultsError` if the Table does not exist.

  ## Examples

      iex> get_table!(123)
      %Table{}

      iex> get_table!(456)
      ** (Ecto.NoResultsError)

  """
  def get_table!(id), do: Repo.get!(Table, id)

  @doc """
  Creates a table.

  ## Examples

      iex> create_table(%{field: value})
      {:ok, %Table{}}

      iex> create_table(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  # def create_table(attrs \\ %{}) do
  #   %Table{}
  #   |> Table.changeset(attrs)
  #   |> Repo.insert()
  # end

  # Function to create a single table
  def create_table(attrs \\ %{}) do
    %Table{}
    |> Table.changeset(attrs)
    |> Repo.insert()
  end

  def update_table(%Table{} = table, attrs) do
    table
    |> Table.changeset(attrs)
    |> Repo.update()
  end
  defp create_qrCode(tableId, restaurantId) do
    link = "#{System.get_env("BASE_URL")}/app/restaurants/#{restaurantId}/menus?table_id=#{tableId}"|> IO.inspect()
    QRCodeEx.encode(link) |> QRCodeEx.png() |> Base.encode64()
  end
  # Function to create multiple tables at once
  def create_tables(tables_params) do
    Enum.map(tables_params, fn params ->
      case create_table(params) do
        {:ok, table} ->
          # Update the table with the generated QR code
          update_table(table, %{qr_code: create_qrCode(table.id, table.restaurant_id)})
        {:error, changeset} ->
          {:error, changeset}
      end
    end)
  end

  def update_qr_code(table_id) do
    case Repo.get(Table, table_id) do
      nil -> {:error, "Table not found"}
      %Table{} = table ->
        new_qr_code = create_qrCode(table_id, table.restaurant_id)
        changeset = Table.changeset(table, %{qr_code: new_qr_code})
        case Repo.update(changeset) do
          {:ok, updated_table} -> {:ok, updated_table}
          {:error, changeset} -> {:error, changeset}
        end
    end
  end

  @doc """
  Updates a table.

  ## Examples

      iex> update_table(table, %{field: new_value})
      {:ok, %Table{}}

      iex> update_table(table, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """

  @doc """
  Deletes a table.

  ## Examples

      iex> delete_table(table)
      {:ok, %Table{}}

      iex> delete_table(table)
      {:error, %Ecto.Changeset{}}

  """
  def delete_table(%Table{} = table) do
    Repo.delete(table)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking table changes.

  ## Examples

      iex> change_table(table)
      %Ecto.Changeset{data: %Table{}}

  """
  def change_table(%Table{} = table, attrs \\ %{}) do
    Table.changeset(table, attrs)
  end
end
