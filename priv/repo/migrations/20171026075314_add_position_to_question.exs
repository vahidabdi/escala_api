defmodule Escala.Repo.Migrations.AddPositionToQuestion do
  use Ecto.Migration

  def change do
    alter table(:questions) do
      add :position, :integer, null: false
    end

    create unique_index(:questions, [:survey_id, :position], name: :unique_position)
  end
end
