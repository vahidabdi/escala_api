defmodule Escala.CMS.QuestionOption do
  @moduledoc """
  Question Option
  """

  use Ecto.Schema
  import Ecto.Changeset
  alias Escala.CMS.QuestionOption
  alias Escala.CMS.Question
  alias Escala.CMS.OptionChoice

  @primary_key {:id, Ecto.UUID, read_after_writes: true}
  @foreign_key_type Ecto.UUID

  schema "question_options" do
    belongs_to :question, Question
    belongs_to :option_choice, OptionChoice
  end

  @doc false
  def changeset(%QuestionOption{} = question_option, attrs) do
    question_option
    |> cast(attrs, [:question_id, :option_choice_id])
    |> validate_required([:question_id, :option_choice_id])
    |> validate_accept_option(:question_id)
    |> foreign_key_constraint(:question_id)
    |> foreign_key_constraint(:option_choice_id)
  end

  defp validate_accept_option(changeset, field) do
    import Ecto.Query
    validate_change(changeset, field, fn :question_id, question_id ->
      query = from q in Question, where: q.id == ^question_id, preload: [:input_type]
      question = Escala.Repo.one(query)
      case question.input_type.has_option do
        true -> []
        false -> [question_id: "can't have option"]
      end
    end)
  end
end
