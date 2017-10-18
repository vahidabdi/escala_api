defmodule Escala.Repo.Migrations.CreateQuestions do
  use Ecto.Migration

  def change do
    create table(:questions, primary_key: false) do
      add :id, :uuid, primary_key: true, default: fragment("uuid_generate_v4()")
      add :question_text, :text, null: false
      add :question_subtext, :text
      add :answer_required, :boolean, default: false, null: false
      add :allow_multiple_option, :boolean, default: false, null: false
      add :input_type_id, references(:input_types, on_delete: :nothing, type: :uuid), null: false
      add :survey_id, references(:surveys, on_delete: :nothing, type: :uuid), null: false

      timestamps(type: :timestamptz)
    end

    create index(:questions, [:input_type_id])
    create index(:questions, [:survey_id])
  end
end
