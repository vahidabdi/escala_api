defmodule Escala.Repo.Migrations.CreateSections do
  use Ecto.Migration

  def change do
    create table(:sections, primary_key: false) do
      add :id, :uuid, primary_key: true, default: fragment("uuid_generate_v4()")
      add :header, :text, null: false
      add :sub_header, :text
      add :survey_id, references(:surveys, on_delete: :nothing, type: :uuid), null: false

      timestamps(type: :timestamptz)
    end

    create index(:sections, [:survey_id])
  end
end
