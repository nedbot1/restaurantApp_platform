defmodule RestaurantAppPlatformWeb.AccountJSON do
  alias RestaurantAppPlatform.Accounts.Account

  @doc """
  Renders a list of accounts.
  """
  def index(%{accounts: accounts}) do
    %{data: Enum.map(accounts, &data/1)}
  end

  @doc """
  Renders a single account.
  """
  def show(%{account: account}) do
    %{data: data(account)}
  end

  defp data(%Account{} = account) do
    %{
      id: account.id,
      email: account.email
    }
  end

  @doc """
  Renders account with token.
  """
  def render("account_token.json", %{account: account, token: token}) do
    %{
      id: account.id,
      email: account.email,
      token: token
    }
  end
end
