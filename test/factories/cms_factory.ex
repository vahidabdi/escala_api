defmodule Escala.CMSFactory do
  use ExMachina.Ecto, repo: Escala.Repo

  defmacro __using__(_opts) do
    quote do
      def section_factory do
        %Escala.CMS.Section{
          header: sequence("header"),
        }
      end

      def survey_factory do
        %Escala.CMS.Survey{
          name: "sample survey",
          user: build(:account_user),
        }
      end

      def with_sections(%Escala.CMS.Survey{} = survey) do
        insert_pair(:section, survey: survey)
        survey
      end
    end
  end
end
