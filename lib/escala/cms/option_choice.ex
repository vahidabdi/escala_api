defmodule Escala.CMS.OptionChoice do
  @moduledoc """
  Option Choice
  """
  use Ecto.Schema
  import Ecto.Changeset
  alias Escala.CMS.OptionChoice
  alias Escala.CMS.Question
  alias Escala.CMS.QuestionOption

  @primary_key {:id, Ecto.UUID, read_after_writes: true}
  @foreign_key_type Ecto.UUID
  @timestamps_opts [type: :utc_datetime, usec: false]

  schema "option_choices" do
    field(:option_choice_name, :string)
    field(:option_choice_value, :string)

    belongs_to(:question, Question)
    has_many(:question_options, QuestionOption)

    timestamps()
  end

  @doc false
  def changeset(%OptionChoice{} = option_choice, attrs) do
    option_choice
    |> cast(attrs, [:option_choice_name, :option_choice_value, :question_id])
    |> validate_required([:option_choice_name, :option_choice_value, :question_id])
    |> foreign_key_constraint(:question_id)
  end
end
