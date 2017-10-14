defmodule Escala.CMS.OptionChoiceResolver do
  alias Escala.CMS

  def find(%{id: id}, %{context: %{current_user: %{id: _id}}}) do
    case CMS.get_option_choice(id) do
      nil -> {:error, "یافت نشد"}
      o -> {:ok, o}
    end
  end
  def find(_, _) do
    {:error, "مجوز ندارید"}
  end

  def create(%{input: args}, %{context: %{current_user: %{id: _id}}}) do
    case CMS.create_option_choice(args) do
      {:ok, o} -> {:ok, o}
      {:error, _} -> {:error, "مشکل در ایجاد"}
    end
  end
end
