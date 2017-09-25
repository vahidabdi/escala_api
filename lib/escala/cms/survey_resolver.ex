defmodule Escala.CMS.SurveyResolver do
  @moduledoc """
  Survey Resolver
  """
  alias Escala.CMS

  def list_surveys(_, %{context: %{current_user: %{id: id}}}) do
    {:ok, CMS.list_surveys(id)}
  end
  def list_surveys(_, _) do
    {:error, "unauthorized"}
  end
end
