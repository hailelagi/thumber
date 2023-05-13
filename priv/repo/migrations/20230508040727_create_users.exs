defmodule Thumber.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :email, :string, null: false
      add :provider, :string, null: false
      add :schedule_delete, :boolean, null: false
      add :token, :string, null: false

      timestamps()
    end

    create unique_index(:users, [:email])
  end
end
