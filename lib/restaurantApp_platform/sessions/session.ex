defmodule RestaurantAppPlatform.Sessions.Session do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:id, :session_token, :start_time, :end_time, :table_id, :table]}
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "sessions" do
    field :session_token, :string
    field :start_time, :utc_datetime
    field :end_time, :utc_datetime
    belongs_to :table, RestaurantAppPlatform.Tables.Table
    timestamps(type: :utc_datetime)

    has_many :orders, RestaurantAppPlatform.Orders.Order
  end

  @doc false
  def changeset(session, attrs) do
    session
    |> cast(attrs, [:table_id, :session_token, :start_time, :end_time])
    |> validate_required([:table_id,:session_token, :start_time, :end_time])
  end
end
