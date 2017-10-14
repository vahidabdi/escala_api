defmodule Escala.CMS.Section do
  @moduledoc """
  Survey Section
  """
  use Ecto.Schema
  import Ecto.Changeset
  alias Escala.CMS.Section
  alias Escala.CMS.Survey
  alias Escala.CMS.Question

  @primary_key {:id, Ecto.UUID, read_after_writes: true}
  @foreign_key_type Ecto.UUID
  @timestamps_opts [type: :utc_datetime, usec: false]

  schema "sections" do
    field :header, :string
    field :sub_header, :string

    belongs_to :survey, Survey
    has_many :questions, Question

    timestamps()
  end

  @doc false
  def changeset(%Section{} = section, attrs) do
    section
    |> cast(attrs, [:header, :sub_header, :survey_id])
    |> validate_required([:header, :survey_id])
    |> foreign_key_constraint(:survey_id)
  end
end
