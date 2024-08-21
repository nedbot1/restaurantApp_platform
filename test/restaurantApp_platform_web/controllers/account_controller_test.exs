defmodule RestaurantAppPlatformWeb.AccountControllerTest do
  use RestaurantAppPlatformWeb.ConnCase

  import RestaurantAppPlatform.AccountsFixtures

  alias RestaurantAppPlatform.Accounts.Account

  @create_attrs %{
    owner_name: "some owner_name",
    email: "some email",
    password_hash: "some password_hash",
    salt: "some salt",
    phone_number: "some phone_number",
    suscribed_at: ~U[2024-08-20 04:32:00Z]
  }
  @update_attrs %{
    owner_name: "some updated owner_name",
    email: "some updated email",
    password_hash: "some updated password_hash",
    salt: "some updated salt",
    phone_number: "some updated phone_number",
    suscribed_at: ~U[2024-08-21 04:32:00Z]
  }
  @invalid_attrs %{owner_name: nil, email: nil, password_hash: nil, salt: nil, phone_number: nil, suscribed_at: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all accounts", %{conn: conn} do
      conn = get(conn, ~p"/api/accounts")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create account" do
    test "renders account when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/accounts", account: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/accounts/#{id}")

      assert %{
               "id" => ^id,
               "email" => "some email",
               "owner_name" => "some owner_name",
               "password_hash" => "some password_hash",
               "phone_number" => "some phone_number",
               "salt" => "some salt",
               "suscribed_at" => "2024-08-20T04:32:00Z"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/accounts", account: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update account" do
    setup [:create_account]

    test "renders account when data is valid", %{conn: conn, account: %Account{id: id} = account} do
      conn = put(conn, ~p"/api/accounts/#{account}", account: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/accounts/#{id}")

      assert %{
               "id" => ^id,
               "email" => "some updated email",
               "owner_name" => "some updated owner_name",
               "password_hash" => "some updated password_hash",
               "phone_number" => "some updated phone_number",
               "salt" => "some updated salt",
               "suscribed_at" => "2024-08-21T04:32:00Z"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, account: account} do
      conn = put(conn, ~p"/api/accounts/#{account}", account: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete account" do
    setup [:create_account]

    test "deletes chosen account", %{conn: conn, account: account} do
      conn = delete(conn, ~p"/api/accounts/#{account}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/accounts/#{account}")
      end
    end
  end

  defp create_account(_) do
    account = account_fixture()
    %{account: account}
  end
end
