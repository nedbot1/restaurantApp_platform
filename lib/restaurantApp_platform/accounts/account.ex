defmodule RestaurantAppPlatform.Accounts.Account do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:id, :owner_name, :email, :phone_number, :subscribed_at]}
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "accounts" do
    field :owner_name, :string
    field :email, :string
    field :password_hash, :string
    field :phone_number, :string
    field :subscribed_at, :utc_datetime, default: nil
    has_many :restaurants, RestaurantAppPlatform.Restaurants.Restaurant
    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(account, attrs) do
    account
    |> cast(attrs, [:owner_name, :email, :password_hash, :phone_number, :subscribed_at])
    |> validate_required([:owner_name, :email, :password_hash, :phone_number])
    |> unique_constraint(:email)
    |> put_password_hash()
  end

  defp put_password_hash(changeset) do
    if password = get_change(changeset, :password_hash) do
      hashed_password = Bcrypt.hash_pwd_salt(password)
      put_change(changeset, :password_hash, hashed_password)
    else
      changeset
    end
  end
end
