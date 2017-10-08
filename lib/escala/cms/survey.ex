defmodule Escala.CMS.Survey do
  @moduledoc """
  Survey module
  """
  use Ecto.Schema
  import Ecto.Changeset
  alias Escala.CMS.Survey
  alias Escala.Accounts.User

  @primary_key {:id, Ecto.UUID, read_after_writes: true}
  @foreign_key_type Ecto.UUID
  @timestamps_opts [type: :utc_datetime, usec: false]

  schema "surveys" do
    field :name, :string
    field :welcome, :string
    field :title, :string
    field :description, :string
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(%Survey{} = survey, attrs) do
    survey
    |> cast(attrs, [:name, :title, :description, :welcome, :user_id])
    |> validate_required([:name, :user_id])
    |> foreign_key_constraint(:user_id)
  end
end
