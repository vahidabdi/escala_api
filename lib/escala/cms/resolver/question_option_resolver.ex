defmodule Escala.CMS.QuestionOptionResolver do
  alias Escala.CMS

  def find(%{id: id}, %{context: %{current_user: %{id: _id}}}) do
    case CMS.get_question_option(id) do
      nil -> {:error, "یافت نشد"}
      q -> {:ok, q}
    end
  end

  def find(_, _) do
    {:error, "مجوز ندارید"}
  end
end
