defmodule Escala.AccountFactory do
  use ExMachina

  defmacro __using__(_opts) do
    quote do
      def account_user_factory do
        %Escala.Accounts.User{
          email: sequence(:email, &"email#{&1}@example.com"),
          username: sequence(:username, &"name#{&1}"),
        }
      end
    end
  end
end
