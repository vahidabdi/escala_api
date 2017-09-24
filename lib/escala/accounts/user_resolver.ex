defmodule Escala.Accounts.UserResolver do
  alias Escala.Accounts

  def login(%{provider: provider, code: code}, _) do
    Accounts.login(provider: provider, code: code)
  end
end
