defmodule Escala.Repo.Migrations.CreateCmsSurveys do
  use Ecto.Migration

  def change do
    create table(:cms_surveys, primary_key: false) do
      add :id, :uuid, primary_key: true, default: fragment("uuid_generate_v4()")
      add :name, :text, null: false
      add :title, :text
      add :description, :text
      add :welcome, :text
      add :user_id, references(:account_users, on_delete: :nothing, type: :uuid), null: false

      timestamps(type: :timestamptz)
    end

    create index(:cms_surveys, [:user_id])
  end
end
