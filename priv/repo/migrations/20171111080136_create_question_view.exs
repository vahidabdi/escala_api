defmodule Escala.Repo.Migrations.CreateQuestionView do
  use Ecto.Migration

  def up do
    execute """
    CREATE VIEW question_views AS
    SELECT q.* FROM questions AS q INNER JOIN input_types AS it on q.input_type_id = it.id
    """
  end

  def down do
    execute """
    DROP VIEW question_views;
    """
  end
end
