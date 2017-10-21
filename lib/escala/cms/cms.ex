defmodule Escala.CMS do
  @moduledoc """
  CMS module
  """

  import Ecto.Query, warn: false
  import Ecto.UUID, warn: false

  alias Ecto.UUID
  alias Escala.Repo
  alias Escala.CMS.Survey
  alias Escala.CMS.Section
  alias Escala.CMS.OptionGroup
  alias Escala.CMS.OptionChoice
  alias Escala.CMS.InputType
  alias Escala.CMS.Question
  alias Escala.CMS.QuestionOption

  @doc """
  Returns the list of input types
  """
  def list_input_type, do: Repo.all(InputType)

  @doc """
  get input type
  """
  def get_input_type(id) do
    case UUID.cast(id) do
      {:ok, _} -> Repo.get(InputType, id)
      _ -> nil
    end
  end

  @doc """
  Returns the list of survey for user
  """
  def list_user_surveys(id) do
    Survey
    |> where([s], s.user_id == ^id)
    |> Repo.all()
  end

  @doc """
  Returns the list of surveys
  """
  def list_surveys do
    Repo.all(Survey)
  end

  @doc """
  Get a survey
  """
  def get_survey(id) do
    case UUID.cast(id) do
      {:ok, _} -> Repo.get(Survey, id)
      _ -> nil
    end
  end

  @doc """
  Create the new survey
  """
  def create_survey(attrs) do
    %Survey{}
    |> Survey.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates the survey
  """
  def update_survey(%Survey{} = survey, attrs) do
    survey
    |> Survey.changeset(attrs)
    |> Repo.update()
  end

  # Section

  @doc """
  Returns list of survey sections
  """
  def list_sections(survey_id) do
    case UUID.cast(survey_id) do
      {:ok, _} ->
        Repo.all(from(s in Section, where: s.survey_id == ^survey_id))

      _ ->
        nil
    end
  end

  @doc """
  get a section
  """
  def get_section(id) do
    case UUID.cast(id) do
      {:ok, _} -> Repo.get(Section, id)
      _ -> nil
    end
  end

  @doc """
  creates a section
  """
  def create_section(attrs) do
    %Section{}
    |> Section.changeset(attrs)
    |> Repo.insert()
  end

  # OptionGroup

  @doc """
  creates option group
  """
  def create_option_group(attrs) do
    %OptionGroup{}
    |> OptionGroup.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Get a option group
  """
  def get_option_group(id) do
    case UUID.cast(id) do
      {:ok, _} -> Repo.get(OptionGroup, id)
      _ -> nil
    end
  end

  # OptionChoice

  @doc """
  creates option choice
  """
  def create_option_choice(attrs) do
    %OptionChoice{}
    |> OptionChoice.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Get a option choice
  """
  def get_option_choice(id) do
    case UUID.cast(id) do
      {:ok, _} -> Repo.get(OptionChoice, id)
      _ -> nil
    end
  end

  # InputType

  @doc """
  creates input type
  """
  def create_input_type(attrs) do
    %InputType{}
    |> InputType.changeset(attrs)
    |> Repo.insert()
  end

  # Question

  @doc """
  get a question
  """
  def get_question(id) do
    case UUID.cast(id) do
      {:ok, _} -> Repo.get(Question, id)
      _ -> nil
    end
  end

  @doc """
  creates question
  """
  def create_question(attrs) do
    %Question{}
    |> Question.changeset(attrs)
    |> Repo.insert()
  end

  # QuestionOption

  @doc """
  creates question_option
  """
  def create_question_option(attrs) do
    %QuestionOption{}
    |> QuestionOption.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  get question option
  """
  def get_question_option(id) do
    case UUID.cast(id) do
      {:ok, _} -> Repo.get(QuestionOption, id)
      _ -> nil
    end
  end
end
