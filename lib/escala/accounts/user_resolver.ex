defmodule Escala.Accounts.UserResolver do
  @moduledoc """
  User Account Resolver
  """
  alias Escala.Accounts

  def login(%{provider: provider, code: code}, _) do
    Accounts.login(provider: provider, code: code)
  end
end
