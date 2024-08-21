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
      password_hash: account.password_hash,
      salt: account.salt,
      phone_number: account.phone_number,
      suscribed_at: account.suscribed_at
    }
  end
end
