defmodule Escala.Repo.Migrations.CreateOptionGroups do
  use Ecto.Migration

  def change do
    create table(:option_groups, primary_key: false) do
      add :id, :uuid, primary_key: true, default: fragment("uuid_generate_v4()")
      add :name, :text, null: false
      add :user_id, references(:account_users, on_delete: :nothing, type: :uuid), null: false

      timestamps(type: :timestamptz)
    end

    create index(:option_groups, [:user_id])
  end
end
