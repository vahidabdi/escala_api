defmodule Escala.CMS.InputTypeResolver do
  alias Escala.CMS

  def list(_, _) do
    {:ok, CMS.list_input_type}
  end

  def find(%{id: id}, %{context: %{current_user: %{id: _id}}}) do
    case CMS.get_input_type(id) do
      nil -> {:error, "یافت نشد"}
      i -> {:ok, i}
    end
  end
  def find(_, _) do
    {:error, "مجوز ندارید"}
  end
end
