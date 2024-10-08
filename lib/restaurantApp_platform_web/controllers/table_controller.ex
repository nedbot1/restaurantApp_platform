defmodule RestaurantAppPlatformWeb.TableController do
  use RestaurantAppPlatformWeb, :controller

  alias RestaurantAppPlatform.Tables
  alias RestaurantAppPlatform.Tables.Table

  action_fallback RestaurantAppPlatformWeb.FallbackController

  def index(conn, _params) do
    tables = Tables.list_tables()
    render(conn, "index.json", tables: tables)
  end

  def get_tables_by_restaurant_id(conn, %{"restaurant_id" => restaurant_id}) do
  tables = Tables.get_tables_by_restaurant_id(restaurant_id)
  render(conn, "index.json", tables: tables)
end

  def create(conn, %{"table" => table_params}) do
    with {:ok, %Table{} = table} <- Tables.create_table(table_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/tables/#{table}")
      |> render(:show, table: table)
    end
  end

   # Batch creation of tables
  def create_batch(conn, %{"tables" => tables_params}) do
  created_tables = Tables.create_tables(tables_params)

  case Enum.all?(created_tables, &match?({:ok, _}, &1)) do
    true ->
      tables = Enum.map(created_tables, fn {:ok, table} -> table end)
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/tables")
      |> render(:index, tables: tables)
    false ->
      conn
      |> put_status(:unprocessable_entity)
      |> render(:error, message: "Failed to create some tables")
  end
end

  def regenerate_qr_code(conn, %{"id" => table_id}) do
     case Tables.update_qr_code(table_id) do
        {:ok, updated_table} ->
        conn
        |> put_status(:ok)
        |> json(%{message: "QR Code updated successfully", table: updated_table})

      {:error, reason} ->
        # If there's an error, handle it here
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{error: reason})
     end
  end

  def show(conn, %{"id" => id}) do
    table = Tables.get_table!(id)
    render(conn, "show.json", table: table)
  end

  def update(conn, %{"id" => id, "table" => table_params}) do
    table = Tables.get_table!(id)

    with {:ok, %Table{} = table} <- Tables.update_table(table, table_params) do
      render(conn, :show, table: table)
    end
  end

  def delete(conn, %{"id" => id}) do
    table = Tables.get_table!(id)

    with {:ok, %Table{}} <- Tables.delete_table(table) do
      send_resp(conn, :no_content, "")
    end
  end
end
