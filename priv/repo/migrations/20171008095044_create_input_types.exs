defmodule Escala.Repo.Migrations.CreateInputTypes do
  use Ecto.Migration

  def change do
    create table(:input_types, primary_key: false) do
      add :id, :uuid, primary_key: true, default: fragment("uuid_generate_v4()")
      add :name, :text, null: false
      add :has_option, :boolean, default: false, null: false
    end

    create unique_index(:input_types, [:name])
  end
end
