defmodule Escala.CMSFactory do
  use ExMachina.Ecto, repo: Escala.Repo

  defmacro __using__(_opts) do
    quote do
      def cms_survey_factory do
        %Escala.CMS.Survey{
          name: "sample survey",
          user: build(:account_user),
        }
      end
    end
  end
end
