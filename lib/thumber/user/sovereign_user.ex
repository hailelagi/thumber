defmodule Thumber.User.Sovereign do
  use Ecto.Schema
  use Cloak.Ecto.Binary, vault: Thumber.DynamicVault

  alias Thumber.Encrypted.DynamicBinary, as: Binary
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "users" do
    field :email, Binary
    field :token, Binary
    field :provider, :string, default: "github"
    field :schedule_delete, :boolean, default: false

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :token])
    |> validate_required([:email, :token])
    |> unique_constraint(:email)
  end
end
