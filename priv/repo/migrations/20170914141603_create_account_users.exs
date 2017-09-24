defmodule Escala.Repo.Migrations.CreateAccountUsers do
  use Ecto.Migration

  def up do
    execute "CREATE EXTENSION IF NOT EXISTS \"uuid-ossp\""
    create table(:account_users, primary_key: false) do
      add :id, :uuid, primary_key: true, default: fragment("uuid_generate_v4()")
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

  def down do
    drop table(:account_users)
  end
end
