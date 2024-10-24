defmodule RestaurantAppPlatformWeb.AccountController do
  use RestaurantAppPlatformWeb, :controller
  alias RestaurantAppPlatformWeb.{Auth.Guardian, Auth.ErrorResponse}
  alias RestaurantAppPlatform.{Accounts, Accounts.Account, Users, Users.User}

  plug :is_authorized_account when action in [:update, :delete]

  action_fallback RestaurantAppPlatformWeb.FallbackController

  defp is_authorized_account(conn, _opts)do
    %{params: %{"account" => params}} = conn
    account = Accounts.get_account!(params["id"])
    if conn.assigns.account.id == account.id do
      conn
    else
      raise ErrorResponse.Forbidden
    end
  end

  def index(conn, _params) do
    accounts = Accounts.list_accounts()
    render(conn, :index, accounts: accounts)
  end

  def create(conn, %{"account" => account_params}) do
    with {:ok, %Account{} = account} <- Accounts.create_account(account_params),
         {:ok, token, _claims} <- Guardian.encode_and_sign(account),
         {:ok, %User{} = _users} <- Users.create_user(account, account_params)
         do
      conn
      |> put_status(:created)
      # |> put_resp_header("location", ~p"/api/accounts/#{account}")
      |> render("account_token.json", account: account, token: token)
    end
  end

  def sign_in(conn, %{"email" => email, "hash_password" => hash_password})do
    case Guardian.authenticate(email, hash_password)do
      {:ok, account, token} ->
        conn
        |> Plug.Conn.put_session(:account_id, account.id)
        |> put_status(:ok)
        |> render("account_token.json", account: account, token: token)
        {:error, :unauthorized} -> raise ErrorResponse.Unauthorized, message: "email or password is in correct"
    end
  end

  def refresh_session(conn, %{})do
    old_token = Guardian.Plug.current_token(conn)
    case Guardian.decode_and_verify(old_token)do
      {:ok, claims} ->
        case Guardian.resource_from_claims(claims)do
          {:ok, account} ->
            {:ok, _old, {new_token, _new_claims}} = Guardian.refresh(old_token)
            conn
            |> Plug.Conn.put_session(:account_id, account.id)
            |> put_status(:ok)
            |> render("account_token.json", %{account: account, token: new_token})
            {:error, _reason} -> raise ErrorResponse.NotFound
        end
        {:error, _reason} -> raise ErrorResponse.NotFound
    end
  end

  def sign_out(conn, %{})do
    account = conn.assigns[:account]
    token = Guardian.Plug.current_token(conn)
    Guardian.revoke(token)
    conn
    |> Plug.Conn.clear_session()
    |> put_status(:ok)
    |> render("account_token.json", %{account: account, token: nil})
  end

  def show(conn, %{"id" => id}) do
    account = Accounts.get_account!(id)
    render(conn, :show, account: account)
  end

  def update(conn, %{"account" => account_params}) do
    account = Accounts.get_account!(account_params["id"])

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
end
