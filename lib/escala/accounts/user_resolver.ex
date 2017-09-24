defmodule Escala.Accounts.UserResolver do
  @moduledoc """
  User Account Resolver
  """
  alias Escala.Accounts

  def current_user(_, %{context: %{current_user: %{id: id}}}) do
    user = Accounts.get_user(id)
    {:ok, user}
  end
  def current_user(_, _) do
    {:error, "invalid token"}
  end

  def login(%{provider: provider, code: code}, _) do
    case Accounts.login(provider: provider, code: code) do
      {:ok, user} ->
        {:ok, jwt, _claims} = Guardian.encode_and_sign(user)
        {:ok, %{user: user, jwt: jwt}}
    end
  end
  def login(_, _) do
    {:error, "problem with login"}
  end
end
