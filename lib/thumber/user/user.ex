defmodule Thumber.User do
  use Ecto.Schema
  use Cloak.Ecto.Binary, vault: Thumber.Vault

  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "users" do
    field :email, Thumber.Encrypted.Binary
    field :token,  Thumber.Encrypted.Binary
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
