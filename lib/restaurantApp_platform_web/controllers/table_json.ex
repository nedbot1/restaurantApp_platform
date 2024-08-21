defmodule RestaurantAppPlatformWeb.TableJSON do
  alias RestaurantAppPlatform.Tables.Table

  @doc """
  Renders a list of tables.
  """
  def index(%{tables: tables}) do
    %{data: for(table <- tables, do: data(table))}
  end

  @doc """
  Renders a single table.
  """
  def show(%{table: table}) do
    %{data: data(table)}
  end

  defp data(%Table{} = table) do
    %{
      id: table.id,
      table_number: table.table_number,
      qr_code: table.qr_code,
      status: table.status
    }
  end
end
