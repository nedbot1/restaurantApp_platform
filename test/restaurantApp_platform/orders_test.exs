defmodule RestaurantAppPlatform.OrdersTest do
  use RestaurantAppPlatform.DataCase

  alias RestaurantAppPlatform.Orders

  describe "orders" do
    alias RestaurantAppPlatform.Orders.Order

    import RestaurantAppPlatform.OrdersFixtures

    @invalid_attrs %{ordered_at: nil, payed_at: nil, total_amount: nil}

    test "list_orders/0 returns all orders" do
      order = order_fixture()
      assert Orders.list_orders() == [order]
    end

    test "get_order!/1 returns the order with given id" do
      order = order_fixture()
      assert Orders.get_order!(order.id) == order
    end

    test "create_order/1 with valid data creates a order" do
      valid_attrs = %{ordered_at: ~U[2024-08-26 08:23:00Z], payed_at: ~U[2024-08-26 08:23:00Z], total_amount: "120.5"}

      assert {:ok, %Order{} = order} = Orders.create_order(valid_attrs)
      assert order.ordered_at == ~U[2024-08-26 08:23:00Z]
      assert order.payed_at == ~U[2024-08-26 08:23:00Z]
      assert order.total_amount == Decimal.new("120.5")
    end

    test "create_order/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Orders.create_order(@invalid_attrs)
    end

    test "update_order/2 with valid data updates the order" do
      order = order_fixture()
      update_attrs = %{ordered_at: ~U[2024-08-27 08:23:00Z], payed_at: ~U[2024-08-27 08:23:00Z], total_amount: "456.7"}

      assert {:ok, %Order{} = order} = Orders.update_order(order, update_attrs)
      assert order.ordered_at == ~U[2024-08-27 08:23:00Z]
      assert order.payed_at == ~U[2024-08-27 08:23:00Z]
      assert order.total_amount == Decimal.new("456.7")
    end

    test "update_order/2 with invalid data returns error changeset" do
      order = order_fixture()
      assert {:error, %Ecto.Changeset{}} = Orders.update_order(order, @invalid_attrs)
      assert order == Orders.get_order!(order.id)
    end

    test "delete_order/1 deletes the order" do
      order = order_fixture()
      assert {:ok, %Order{}} = Orders.delete_order(order)
      assert_raise Ecto.NoResultsError, fn -> Orders.get_order!(order.id) end
    end

    test "change_order/1 returns a order changeset" do
      order = order_fixture()
      assert %Ecto.Changeset{} = Orders.change_order(order)
    end
  end

  describe "order_list" do
    alias RestaurantAppPlatform.Orders.OrderList

    import RestaurantAppPlatform.OrdersFixtures

    @invalid_attrs %{quantity: nil, total_price: nil}

    test "list_order_list/0 returns all order_list" do
      order_list = order_list_fixture()
      assert Orders.list_order_list() == [order_list]
    end

    test "get_order_list!/1 returns the order_list with given id" do
      order_list = order_list_fixture()
      assert Orders.get_order_list!(order_list.id) == order_list
    end

    test "create_order_list/1 with valid data creates a order_list" do
      valid_attrs = %{quantity: 42, total_price: "120.5"}

      assert {:ok, %OrderList{} = order_list} = Orders.create_order_list(valid_attrs)
      assert order_list.quantity == 42
      assert order_list.total_price == Decimal.new("120.5")
    end

    test "create_order_list/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Orders.create_order_list(@invalid_attrs)
    end

    test "update_order_list/2 with valid data updates the order_list" do
      order_list = order_list_fixture()
      update_attrs = %{quantity: 43, total_price: "456.7"}

      assert {:ok, %OrderList{} = order_list} = Orders.update_order_list(order_list, update_attrs)
      assert order_list.quantity == 43
      assert order_list.total_price == Decimal.new("456.7")
    end

    test "update_order_list/2 with invalid data returns error changeset" do
      order_list = order_list_fixture()
      assert {:error, %Ecto.Changeset{}} = Orders.update_order_list(order_list, @invalid_attrs)
      assert order_list == Orders.get_order_list!(order_list.id)
    end

    test "delete_order_list/1 deletes the order_list" do
      order_list = order_list_fixture()
      assert {:ok, %OrderList{}} = Orders.delete_order_list(order_list)
      assert_raise Ecto.NoResultsError, fn -> Orders.get_order_list!(order_list.id) end
    end

    test "change_order_list/1 returns a order_list changeset" do
      order_list = order_list_fixture()
      assert %Ecto.Changeset{} = Orders.change_order_list(order_list)
    end
  end

  describe "orders" do
    alias RestaurantAppPlatform.Orders.Order

    import RestaurantAppPlatform.OrdersFixtures

    @invalid_attrs %{ordered_at: nil, payed_at: nil, total_amount: nil}

    test "list_orders/0 returns all orders" do
      order = order_fixture()
      assert Orders.list_orders() == [order]
    end

    test "get_order!/1 returns the order with given id" do
      order = order_fixture()
      assert Orders.get_order!(order.id) == order
    end

    test "create_order/1 with valid data creates a order" do
      valid_attrs = %{ordered_at: ~U[2024-08-27 05:10:00Z], payed_at: ~U[2024-08-27 05:10:00Z], total_amount: "120.5"}

      assert {:ok, %Order{} = order} = Orders.create_order(valid_attrs)
      assert order.ordered_at == ~U[2024-08-27 05:10:00Z]
      assert order.payed_at == ~U[2024-08-27 05:10:00Z]
      assert order.total_amount == Decimal.new("120.5")
    end

    test "create_order/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Orders.create_order(@invalid_attrs)
    end

    test "update_order/2 with valid data updates the order" do
      order = order_fixture()
      update_attrs = %{ordered_at: ~U[2024-08-28 05:10:00Z], payed_at: ~U[2024-08-28 05:10:00Z], total_amount: "456.7"}

      assert {:ok, %Order{} = order} = Orders.update_order(order, update_attrs)
      assert order.ordered_at == ~U[2024-08-28 05:10:00Z]
      assert order.payed_at == ~U[2024-08-28 05:10:00Z]
      assert order.total_amount == Decimal.new("456.7")
    end

    test "update_order/2 with invalid data returns error changeset" do
      order = order_fixture()
      assert {:error, %Ecto.Changeset{}} = Orders.update_order(order, @invalid_attrs)
      assert order == Orders.get_order!(order.id)
    end

    test "delete_order/1 deletes the order" do
      order = order_fixture()
      assert {:ok, %Order{}} = Orders.delete_order(order)
      assert_raise Ecto.NoResultsError, fn -> Orders.get_order!(order.id) end
    end

    test "change_order/1 returns a order changeset" do
      order = order_fixture()
      assert %Ecto.Changeset{} = Orders.change_order(order)
    end
  end
end
