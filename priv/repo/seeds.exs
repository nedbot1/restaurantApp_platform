# priv/repo/seeds.exs

alias RestaurantAppPlatform.Repo
alias RestaurantAppPlatform.Accounts.Account

# Sample data
accounts = [
  %{
    owner_name: "tobdhen",
    email: "user1@example.com",
    hashed_password: 1234,
    subscribed_at: ~U[2024-09-01T12:00:00Z],
    salt: "1234",
		phone_number: "17661088"
  },
]

# Insert data into the database
Enum.each(accounts, fn account ->
  %Account{}
  |> Account.changeset(account)
  |> Repo.insert!(on_conflict: :nothing)  # Avoid errors if data already exists
end)
