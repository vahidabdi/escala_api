defmodule Escala.Repo.Migrations.AddOptionGroupIdToOptionChoice do
  use Ecto.Migration

  def change do
    alter table(:option_choices) do
      add :option_group_id, references(:option_groups, on_delete: :delete_all, type: :uuid), null: false
    end

    create index(:option_choices, [:option_group_id])
  end
end
