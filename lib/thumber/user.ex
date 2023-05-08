defmodule Thumber.User do
  use Ecto.Schema
  use Cloak.Ecto.Binary, vault: Thumber.Vault

  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "users" do
    field :email, Thumber.Encrypted.Binary
    field :provider, :string
    field :token,  Thumber.Encrypted.Binary

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :provider, :token])
    |> validate_required([:email, :provider, :token])
    |> unique_constraint(:email)
  end
end
