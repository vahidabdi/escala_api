defmodule Escala.CMSFactory do
  use ExMachina.Ecto, repo: Escala.Repo

  defmacro __using__(_opts) do
    quote do
      def input_type_factory do
        %Escala.CMS.InputType{
          name: sequence(:name, &(&1)),
          has_option: false
        }
      end

      def option_choice_factory do
        %Escala.CMS.OptionChoice{
          option_choice_name: "good",
          option_choice_value: "5",
          question: build(:question)
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
    end
  end
end
