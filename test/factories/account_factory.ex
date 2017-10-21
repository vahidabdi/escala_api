defmodule Escala.AccountFactory do
  use ExMachina

  defmacro __using__(_opts) do
    quote do
      def option_group_factory do
        %Escala.CMS.OptionGroup{
          name: sequence("option")
        }
      end

      def account_user_factory do
        %Escala.Accounts.User{
          email: sequence(:email, &"email#{&1}@example.com"),
          username: sequence(:username, &"name#{&1}")
        }
      end

      def with_option_groups(%Escala.Accounts.User{} = user) do
        insert(:option_group, user: user)
        user
      end
    end
  end
end
