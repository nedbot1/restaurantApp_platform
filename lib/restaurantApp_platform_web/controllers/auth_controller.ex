defmodule RestaurantAppPlatformWeb.AuthController do
  use RestaurantAppPlatformWeb, :controller
  alias RestaurantAppPlatform.Accounts

  def register(conn, %{"account" => account_params}) do
    case Accounts.register_account(account_params) do
      {:ok, account} ->
        conn
        |> put_status(:created)
        |> json(%{message: "Account created successfully", account: account})

      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{error: "Unable to create account", details: changeset})
    end
  end

  def login(conn, %{"email" => email, "password" => password}) do
    case Accounts.authenticate_user(email, password) do
      {:ok, %{account: %{email: email, id: id, owner_name: owner_name}, token: {:ok, token}}} ->
        conn
        |> json(%{message: "Login successful", account: %{id: id, email: email, owner_name: owner_name}, token: elem(token, 1)})

      {:error, message} ->
        conn
        |> put_status(:unauthorized)
        |> json(%{error: message})
    end
  end
end
