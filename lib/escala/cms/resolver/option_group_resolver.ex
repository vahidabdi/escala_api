defmodule Escala.CMS.OptionGroupResolver do
  @moduledoc """
  Option Group Resolver
  """
  alias Escala.CMS

  def find(%{id: id}, %{context: %{current_user: %{id: _id}}}) do
    case CMS.get_option_group(id) do
      nil -> {:error, "یافت نشد"}
      o -> {:ok, o}
    end
  end

  def find(_, _) do
    {:error, "مجوز ندارید"}
  end

  def create(%{input: args}, %{context: %{current_user: %{id: user_id}}}) do
    args = args |> Map.merge(%{user_id: user_id})

    case CMS.create_option_group(args) do
      {:ok, op} -> {:ok, op}
      {:error, _} -> {:error, "مشکل در ایجاد"}
    end
  end

  def create(_, _) do
    {:error, "مجوز ندارید"}
  end
end
