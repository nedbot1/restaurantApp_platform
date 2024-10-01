defmodule RestaurantAppPlatformWeb.AccountJSON do
  alias RestaurantAppPlatform.Accounts.Account

  @doc """
  Renders a list of accounts.
  """
  def index(%{accounts: accounts}) do
    %{data: for(account <- accounts, do: data(account))}
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
      owner_name: account.owner_name,
      email: account.email,
      phone_number: account.phone_number,
      subscribed_at: account.subscribed_at
    }
  end
end
