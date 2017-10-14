defmodule Escala.CMS.QuestionResolver do
  alias Escala.CMS

  def find(%{id: id}, %{context: %{current_user: %{id: _id}}}) do
    case CMS.get_question(id) do
      nil -> {:error, "یافت نشد"}
      q -> {:ok, q}
    end
  end
  def find(_, _) do
    {:error, "مجوز ندارید"}
  end

  def create(%{input: args}, %{context: %{current_user: %{id: _user_id}}}) do
    case CMS.create_question(args) do
      {:ok, q} -> {:ok, q}
      {:error, _} -> {:error, "خطا در ایجاد پرسش"}
    end
  end
  def create(_, _) do
    {:error, "مجوز ندارید"}
  end
end
