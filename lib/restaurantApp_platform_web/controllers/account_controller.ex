defmodule RestaurantAppPlatformWeb.AccountController do
  use RestaurantAppPlatformWeb, :controller

  alias RestaurantAppPlatform.Accounts
  alias RestaurantAppPlatform.Accounts.Account

  action_fallback RestaurantAppPlatformWeb.FallbackController

  def index(conn, _params) do
    accounts = Accounts.list_accounts()
    render(conn, :index, accounts: accounts)
  end

  def create(conn, %{"account" => account_params}) do
    with {:ok, %Account{} = account} <- Accounts.create_account(account_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/accounts/#{account}")
      |> render(:show, account: account)
    end
  end

  def show(conn, %{"id" => id}) do
    account = Accounts.get_account!(id)
    render(conn, :show, account: account)
  end

  def update(conn, %{"id" => id, "account" => account_params}) do
    account = Accounts.get_account!(id)

    with {:ok, %Account{} = account} <- Accounts.update_account(account, account_params) do
      render(conn, :show, account: account)
    end
  end

  def delete(conn, %{"id" => id}) do
    account = Accounts.get_account!(id)

    with {:ok, %Account{}} <- Accounts.delete_account(account) do
      send_resp(conn, :no_content, "")
    end
  end

def subscribe_to_premium(conn, %{"id" => id}) do
    account = Accounts.get_account!(id)

    case Accounts.set_premium_subscription(account) do
      {:ok, _account} ->
        json(conn, %{message: "Subscription successful!"})
      # {:error, _changeset} ->
      #   json(conn, %{message: "Failed to subscribe."}, status: 422)
    end
  end
end
