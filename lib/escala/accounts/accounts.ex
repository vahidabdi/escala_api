defmodule Escala.Accounts do
  @moduledoc false

  import Ecto.Query, warn: false
  import Ecto.UUID, warn: false

  alias Ecto.UUID
  alias Escala.Repo
  alias Escala.Accounts.User

  @doc """
  Returns the list of users.
  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Get a user
  """
  def get_user(id) do
    case UUID.cast id do
      {:ok, _} -> Repo.get(User, id)
      _ -> nil
    end
  end

  @doc """
  Create a user
  """
  def create_user(attrs) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Update a user
  """
  def update_user(user, attrs) do
    user
    |> User.update_changeset(attrs)
    |> Repo.update()
  end
end
