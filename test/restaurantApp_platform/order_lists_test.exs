defmodule RestaurantAppPlatform.OrderListsTest do
  use RestaurantAppPlatform.DataCase

  alias RestaurantAppPlatform.OrderLists

  describe "order_lists" do
    alias RestaurantAppPlatform.OrderLists.OrderList

    import RestaurantAppPlatform.OrderListsFixtures

    @invalid_attrs %{quantity: nil, total_price: nil}

    test "list_order_lists/0 returns all order_lists" do
      order_list = order_list_fixture()
      assert OrderLists.list_order_lists() == [order_list]
    end

    test "get_order_list!/1 returns the order_list with given id" do
      order_list = order_list_fixture()
      assert OrderLists.get_order_list!(order_list.id) == order_list
    end

    test "create_order_list/1 with valid data creates a order_list" do
      valid_attrs = %{quantity: 42, total_price: "120.5"}

      assert {:ok, %OrderList{} = order_list} = OrderLists.create_order_list(valid_attrs)
      assert order_list.quantity == 42
      assert order_list.total_price == Decimal.new("120.5")
    end

    test "create_order_list/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = OrderLists.create_order_list(@invalid_attrs)
    end

    test "update_order_list/2 with valid data updates the order_list" do
      order_list = order_list_fixture()
      update_attrs = %{quantity: 43, total_price: "456.7"}

      assert {:ok, %OrderList{} = order_list} = OrderLists.update_order_list(order_list, update_attrs)
      assert order_list.quantity == 43
      assert order_list.total_price == Decimal.new("456.7")
    end

    test "update_order_list/2 with invalid data returns error changeset" do
      order_list = order_list_fixture()
      assert {:error, %Ecto.Changeset{}} = OrderLists.update_order_list(order_list, @invalid_attrs)
      assert order_list == OrderLists.get_order_list!(order_list.id)
    end

    test "delete_order_list/1 deletes the order_list" do
      order_list = order_list_fixture()
      assert {:ok, %OrderList{}} = OrderLists.delete_order_list(order_list)
      assert_raise Ecto.NoResultsError, fn -> OrderLists.get_order_list!(order_list.id) end
    end

    test "change_order_list/1 returns a order_list changeset" do
      order_list = order_list_fixture()
      assert %Ecto.Changeset{} = OrderLists.change_order_list(order_list)
    end
  end
end
