defmodule Escala.CMS.SurveyResolver do
  @moduledoc """
  Survey Resolver
  """
  alias Escala.CMS
  alias Escala.Accounts

  def list_surveys(_, %{context: %{current_user: %{id: id}}}) do
    {:ok, CMS.list_user_surveys(id)}
  end
  def list_surveys(_, _) do
    {:error, "مجوز ندارید"}
  end

  def find(%{id: id}, %{context: %{current_user: %{id: _user_id}}}) do
    case CMS.get_survey(id) do
      nil ->
        {:error, "survey not found"}
      survey -> {:ok, survey}
    end
  end
  def find(_, _) do
    {:error, "مجوز ندارید"}
  end

  def create_survey(%{input: args}, %{context: %{current_user: %{id: user_id}}}) do
    user = Accounts.get_user(user_id)
    case user do
      nil -> {:error, "محوز ساخت پرسشنامه ندارید"}
      _user ->
        args = Map.merge(args, %{user_id: user_id})
        case CMS.create_survey(args) do
          {:ok, survey} -> {:ok, survey}
          {:error, _changeset} -> {:error, "خطا در ایجاد پرسشنامه"}
        end
    end
  end
  def create_survey(_, _) do
    {:error, "محوز ساخت پرسشنامه ندارید"}
  end
end
