defmodule Escala.CMS.SectionResolver do
  alias Escala.CMS

  def find(%{id: id}, %{context: %{current_user: %{id: _id}}}) do
    case CMS.get_section(id) do
      nil -> {:error, "یافت نشد"}
      s -> {:ok, s}
    end
  end

  def find(_, _) do
    {:error, "مجوز ندارید"}
  end

  def create(%{input: args}, %{context: %{current_user: %{id: _id}}}) do
    case CMS.create_section(args) do
      {:ok, s} -> {:ok, s}
      {:error, _} -> {:error, "خطا در ایجاد"}
    end
  end

  def create(_, _) do
    {:error, "مجوز ندارید"}
  end
end
