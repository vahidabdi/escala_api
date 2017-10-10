defmodule Escala.Repo.Migrations.CreateQuestionOptions do
  use Ecto.Migration

  def change do
    create table(:question_options, primary_key: false) do
      add :id, :uuid, primary_key: true, default: fragment("uuid_generate_v4()")
      add :question_id, references(:questions, on_delete: :nothing, type: :uuid), null: false
      add :option_choice_id, references(:option_choices, on_delete: :nothing, type: :uuid), null: false
    end

    create index(:question_options, [:question_id])
    create index(:question_options, [:option_choice_id])
  end
end
