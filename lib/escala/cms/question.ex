defmodule Escala.CMS.Question do
  @moduledoc """
  Question Module
  """
  use Ecto.Schema
  import Ecto.Changeset
  alias Escala.CMS.Question
  alias Escala.CMS.Survey
  alias Escala.CMS.InputType
  alias Escala.CMS.QuestionOption

  @primary_key {:id, Ecto.UUID, read_after_writes: true}
  @foreign_key_type Ecto.UUID
  @timestamps_opts [type: :utc_datetime, usec: false]

  schema "questions" do
    field(:question_text, :string)
    field(:question_subtext, :string)
    field(:allow_multiple_option, :boolean, default: false)
    field(:answer_required, :boolean, default: false)
    field(:position, :integer)

    belongs_to(:input_type, InputType)
    belongs_to(:survey, Survey)
    has_many(:question_options, QuestionOption)

    timestamps()
  end

  @doc false
  def changeset(%Question{} = question, attrs) do
    question
    |> cast(attrs, [
         :question_text,
         :question_subtext,
         :answer_required,
         :allow_multiple_option,
         :input_type_id,
         :survey_id,
         :position
       ])
    |> validate_required([:question_text, :survey_id, :input_type_id, :position])
    |> foreign_key_constraint(:survey_id)
    |> foreign_key_constraint(:input_type_id)
    |> unique_constraint(:position, name: :unique_position)
  end
end
