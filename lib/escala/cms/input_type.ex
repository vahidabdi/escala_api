defmodule Escala.CMS.InputType do
  @moduledoc """
  InputType
  """

  use Ecto.Schema
  import Ecto.Changeset
  alias Escala.CMS.InputType
  alias Escala.CMS.Question

  @primary_key {:id, Ecto.UUID, read_after_writes: true}

  schema "input_types" do
    field(:name, :string)
    field(:has_option, :boolean)

    has_many(:questions, Question)
  end

  @doc false
  def changeset(%InputType{} = input_type, attrs) do
    input_type
    |> cast(attrs, [:name, :has_option])
    |> validate_required([:name, :has_option])
    |> unique_constraint(:name)
  end
end
