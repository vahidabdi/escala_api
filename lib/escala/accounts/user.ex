defmodule Escala.Accounts.User do
  @moduledoc """
  User schema
  """
  use Ecto.Schema
  import Ecto.Changeset
  alias Escala.Accounts.User

  @primary_key {:id, :binary_id, autogenerate: true}
  @timestamps_opts [type: :utc_datetime, usec: false]

  schema "account_users" do
    field :email, :string
    field :username, :string
    field :first_name, :string
    field :last_name, :string
    field :picture, :string
    field :providers, {:array, :string}

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:email, :username, :first_name, :last_name, :picture, :providers])
    |> validate_required([:email])
    |> validate_format(:email, ~r/\A.+@.+\..+\z/)
    |> validate_format(:username, ~r/\A[a-zA-Z][a-zA-z_0-9]+\z/)
    |> validate_length(:username, min: 4)
    |> unique_constraint(:email)
    |> unique_constraint(:username)
  end

  def update_changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:username, :first_name, :last_name])
    |> validate_format(:username, ~r/\A[a-zA-Z][a-zA-z_0-9]+\z/)
    |> validate_length(:username, min: 4)
    |> unique_constraint(:username)
  end
end
