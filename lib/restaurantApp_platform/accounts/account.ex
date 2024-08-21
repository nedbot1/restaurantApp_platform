defmodule RestaurantAppPlatform.Accounts.Account do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "accounts" do
    field :owner_name, :string
    field :email, :string
    field :password_hash, :string
    field :salt, :string
    field :phone_number, :string
    field :suscribed_at, :utc_datetime

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(account, attrs) do
    account
    |> cast(attrs, [:owner_name, :email, :password_hash, :salt, :phone_number, :suscribed_at])
    |> validate_required([:owner_name, :email, :password_hash, :salt, :phone_number, :suscribed_at])
    |> unique_constraint(:email)
  end
end
