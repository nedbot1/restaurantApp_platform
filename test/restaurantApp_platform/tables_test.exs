defmodule RestaurantAppPlatform.TablesTest do
  use RestaurantAppPlatform.DataCase

  alias RestaurantAppPlatform.Tables

  describe "tables" do
    alias RestaurantAppPlatform.Tables.Table

    import RestaurantAppPlatform.TablesFixtures

    @invalid_attrs %{status: nil, table_number: nil, qr_code: nil}

    test "list_tables/0 returns all tables" do
      table = table_fixture()
      assert Tables.list_tables() == [table]
    end

    test "get_table!/1 returns the table with given id" do
      table = table_fixture()
      assert Tables.get_table!(table.id) == table
    end

    test "create_table/1 with valid data creates a table" do
      valid_attrs = %{status: "some status", table_number: "some table_number", qr_code: "some qr_code"}

      assert {:ok, %Table{} = table} = Tables.create_table(valid_attrs)
      assert table.status == "some status"
      assert table.table_number == "some table_number"
      assert table.qr_code == "some qr_code"
    end

    test "create_table/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tables.create_table(@invalid_attrs)
    end

    test "update_table/2 with valid data updates the table" do
      table = table_fixture()
      update_attrs = %{status: "some updated status", table_number: "some updated table_number", qr_code: "some updated qr_code"}

      assert {:ok, %Table{} = table} = Tables.update_table(table, update_attrs)
      assert table.status == "some updated status"
      assert table.table_number == "some updated table_number"
      assert table.qr_code == "some updated qr_code"
    end

    test "update_table/2 with invalid data returns error changeset" do
      table = table_fixture()
      assert {:error, %Ecto.Changeset{}} = Tables.update_table(table, @invalid_attrs)
      assert table == Tables.get_table!(table.id)
    end

    test "delete_table/1 deletes the table" do
      table = table_fixture()
      assert {:ok, %Table{}} = Tables.delete_table(table)
      assert_raise Ecto.NoResultsError, fn -> Tables.get_table!(table.id) end
    end

    test "change_table/1 returns a table changeset" do
      table = table_fixture()
      assert %Ecto.Changeset{} = Tables.change_table(table)
    end
  end
end
