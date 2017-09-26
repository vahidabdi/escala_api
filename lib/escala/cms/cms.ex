defmodule Escala.CMS do
  @moduledoc """
  CMS module
  """

  import Ecto.Query, warn: false
  import Ecto.UUID, warn: false

  alias Ecto.UUID
  alias Escala.Repo
  alias Escala.CMS.Survey

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
    case UUID.cast id do
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
end
