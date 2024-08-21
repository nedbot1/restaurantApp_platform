defmodule RestaurantAppPlatform.AccountsTest do
  use RestaurantAppPlatform.DataCase

  alias RestaurantAppPlatform.Accounts

  describe "accounts" do
    alias RestaurantAppPlatform.Accounts.Account

    import RestaurantAppPlatform.AccountsFixtures

    @invalid_attrs %{owner_name: nil, email: nil, password_hash: nil, salt: nil, phone_number: nil, suscribed_at: nil}

    test "list_accounts/0 returns all accounts" do
      account = account_fixture()
      assert Accounts.list_accounts() == [account]
    end

    test "get_account!/1 returns the account with given id" do
      account = account_fixture()
      assert Accounts.get_account!(account.id) == account
    end

    test "create_account/1 with valid data creates a account" do
      valid_attrs = %{owner_name: "some owner_name", email: "some email", password_hash: "some password_hash", salt: "some salt", phone_number: "some phone_number", suscribed_at: ~U[2024-08-20 04:32:00Z]}

      assert {:ok, %Account{} = account} = Accounts.create_account(valid_attrs)
      assert account.owner_name == "some owner_name"
      assert account.email == "some email"
      assert account.password_hash == "some password_hash"
      assert account.salt == "some salt"
      assert account.phone_number == "some phone_number"
      assert account.suscribed_at == ~U[2024-08-20 04:32:00Z]
    end

    test "create_account/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_account(@invalid_attrs)
    end

    test "update_account/2 with valid data updates the account" do
      account = account_fixture()
      update_attrs = %{owner_name: "some updated owner_name", email: "some updated email", password_hash: "some updated password_hash", salt: "some updated salt", phone_number: "some updated phone_number", suscribed_at: ~U[2024-08-21 04:32:00Z]}

      assert {:ok, %Account{} = account} = Accounts.update_account(account, update_attrs)
      assert account.owner_name == "some updated owner_name"
      assert account.email == "some updated email"
      assert account.password_hash == "some updated password_hash"
      assert account.salt == "some updated salt"
      assert account.phone_number == "some updated phone_number"
      assert account.suscribed_at == ~U[2024-08-21 04:32:00Z]
    end

    test "update_account/2 with invalid data returns error changeset" do
      account = account_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_account(account, @invalid_attrs)
      assert account == Accounts.get_account!(account.id)
    end

    test "delete_account/1 deletes the account" do
      account = account_fixture()
      assert {:ok, %Account{}} = Accounts.delete_account(account)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_account!(account.id) end
    end

    test "change_account/1 returns a account changeset" do
      account = account_fixture()
      assert %Ecto.Changeset{} = Accounts.change_account(account)
    end
  end
end
