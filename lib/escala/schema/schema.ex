defmodule Escala.Schema do
  @moduledoc """
  Graphql Schema
  """
  use Absinthe.Schema

  import_types Escala.Schema.Type

  query do
    field :current_user, :user do
      resolve &Escala.Accounts.UserResolver.current_user/2
    end
  end

  mutation do
    field :login, :session do
      arg :provider, non_null(:string)
      arg :code, non_null(:string)

      resolve &Escala.Accounts.UserResolver.login/2
    end
  end
end
