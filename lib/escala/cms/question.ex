defmodule Escala.CMS.Question do
  @moduledoc """
  Question Module
  """
  use Ecto.Schema
  import Ecto.Changeset
  alias Escala.CMS.Question
  alias Escala.CMS.Section
  alias Escala.CMS.InputType
  alias Escala.CMS.QuestionOption

  @primary_key {:id, Ecto.UUID, read_after_writes: true}
  @foreign_key_type Ecto.UUID
  @timestamps_opts [type: :utc_datetime, usec: false]

  schema "questions" do
    field :question_text, :string
    field :question_subtext, :string
    field :allow_multiple_option, :boolean, default: false
    field :answer_required, :boolean, default: false

    belongs_to :input_type, InputType
    belongs_to :section, Section
    has_many :question_options, QuestionOption

    timestamps()
  end

  @doc false
  def changeset(%Question{} = question, attrs) do
    question
    |> cast(attrs, [:question_text, :question_subtext, :answer_required, :allow_multiple_option, :input_type_id, :section_id])
    |> validate_required([:question_text, :section_id, :input_type_id])
    |> foreign_key_constraint(:section_id)
    |> foreign_key_constraint(:input_type_id)
  end
end
