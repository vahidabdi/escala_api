defmodule Escala.Schema do
  use Absinthe.Schema

  import_types Escala.Schema.Type

  query do
    field :current_user, :user do
      resolve fn _, _ ->
        {
          :ok,
          %{
            email: "ok",
            providers: [
              "google",
              "linkedin"
            ]
          }
        }
      end
    end
  end

  mutation do
    field :login, :user do
      arg :provider, non_null(:string)
      arg :code, non_null(:string)

      resolve &Escala.Accounts.UserResolver.login/2
    end
  end
end
