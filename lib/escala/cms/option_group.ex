defmodule Escala.CMS.OptionGroup do
  @moduledoc """
  Option Group
  """
  use Ecto.Schema
  import Ecto.Changeset
  alias Escala.CMS.OptionGroup
  alias Escala.CMS.OptionChoice
  alias Escala.Accounts.User

  @primary_key {:id, Ecto.UUID, read_after_writes: true}
  @foreign_key_type Ecto.UUID
  @timestamps_opts [type: :utc_datetime, usec: false]

  schema "option_groups" do
    field(:name, :string)

    belongs_to(:user, User)
    has_many(:option_choices, OptionChoice)

    timestamps()
  end

  @doc false
  def changeset(%OptionGroup{} = option_group, attrs) do
    option_group
    |> cast(attrs, [:name, :user_id])
    |> validate_required([:name, :user_id])
    |> foreign_key_constraint(:user_id)
  end
end
