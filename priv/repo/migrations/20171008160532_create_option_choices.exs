defmodule Escala.Repo.Migrations.CreateOptionChoices do
  use Ecto.Migration

  def change do
    create table(:option_choices, primary_key: false) do
      add :id, :uuid, primary_key: true, default: fragment("uuid_generate_v4()")
      add :option_choice_name, :text, null: false
      add :option_choice_value, :text, null: false

      timestamps(type: :timestamptz)
    end

  end
end
