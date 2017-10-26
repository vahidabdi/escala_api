defmodule Escala.CMSFactory do
  use ExMachina.Ecto, repo: Escala.Repo

  defmacro __using__(_opts) do
    quote do
      def input_type_factory do
        %Escala.CMS.InputType{
          name: "short text",
          has_option: false
        }
      end

      def option_group_factory do
        %Escala.CMS.OptionGroup{
          name: "Rate 1-5"
        }
      end

      def option_choice_factory do
        %Escala.CMS.OptionChoice{
          option_choice_name: "good",
          option_choice_value: "5",
          option_group: build(:option_group, user: build(:account_user))
        }
      end

      def section_factory do
        %Escala.CMS.Section{
          header: sequence("header")
        }
      end

      def survey_factory do
        %Escala.CMS.Survey{
          name: "sample survey",
          user: build(:account_user)
        }
      end

      def question_factory do
        %Escala.CMS.Question{
          question_text: "what's your name",
          input_type: build(:input_type),
          survey: build(:survey),
          position: sequence(:position, &(&1))
        }
      end

      def with_sections(%Escala.CMS.Survey{} = survey) do
        insert_pair(:section, survey: survey)
        survey
      end
    end
  end
end
