defmodule Escala.Repo.Migrations.AddHasOptionToInputType do
  use Ecto.Migration

  def change do
    alter table(:input_types) do
      add :has_option, :boolean, default: false, null: false
    end
  end
end
