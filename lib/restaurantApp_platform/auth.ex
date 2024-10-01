defmodule RestaurantAppPlatform.Auth do
  use Joken.Config

  # Use the default Joken configuration, but set your secret key
  @secret_key "1234"

  # Function to generate a JWT for a given account
  def generate_token(account) do
    # Build and sign the token with claims
    token =
      %{exp: DateTime.utc_now() |> DateTime.add(3600, :second)}  # Add expiration time (1 hour)
      |> Joken.token()
      |> Joken.with_claim("account_id", account.id)  # Add custom claim
      |> Joken.sign(@secret_key, rsa: "HS256")  # Sign with your secret
      |> Joken.compact()  # Get the compact representation (string)

    {:ok, token}
  end

  # Optionally, function to verify a token
  def verify_token(token) do
    case Joken.verify(token, @secret_key, rsa: "HS256") do
      {:ok, claims} -> {:ok, claims}
      {:error, error} -> {:error, error}
    end
  end
end
