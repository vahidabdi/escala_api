defmodule Escala.Repo.Migrations.CreateAccountUsers do
  use Ecto.Migration

  def change do
    create table(:account_users, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :email, :text, null: false
      add :username, :text
      add :first_name, :text
      add :last_name, :text
      add :picture, :text
      add :providers, {:array, :text}

      timestamps(type: :timestamptz)
    end

    create unique_index(:account_users, [:email])
    create unique_index(:account_users, [:username])
  end
end
