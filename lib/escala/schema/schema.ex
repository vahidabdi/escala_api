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

    field :option_group, :option_group do
      arg :id, non_null(:id)

      resolve &Escala.CMS.OptionGroupResolver.find/2
    end

    field :option_choice, :option_choice do
      arg :id, non_null(:id)

      resolve &Escala.CMS.OptionChoiceResolver.find/2
    end

    field :question_option, :question_option do
      arg :id, non_null(:id)

      resolve &Escala.CMS.QuestionOptionResolver.find/2
    end

    field :input_types, list_of(:input_type) do
      resolve &Escala.CMS.InputTypeResolver.list/2
    end

    field :input_type, :input_type do
      arg :id, non_null(:id)

      resolve &Escala.CMS.InputTypeResolver.find/2
    end

    field :section, :section do
      arg :id, non_null(:id)

      resolve &Escala.CMS.SectionResolver.find/2
    end

    field :question, :question do
      arg :id, non_null(:id)

      resolve &Escala.CMS.QuestionResolver.find/2
    end

    field :survey, :survey do
      arg :id, non_null(:id)

      resolve &Escala.CMS.SurveyResolver.find/2
    end

    field :surveys, list_of(:survey) do
      resolve &Escala.CMS.SurveyResolver.list_surveys/2
    end
  end

  mutation do
    field :login, :session do
      arg :provider, non_null(:string)
      arg :code, non_null(:string)

      resolve &Escala.Accounts.UserResolver.login/2
    end

    field :create_option_group, :option_group do
      arg :input, non_null(:option_group_input)

      resolve &Escala.CMS.OptionGroupResolver.create/2
    end

    field :create_option_choice, :option_choice do
      arg :input, non_null(:option_choice_input)

      resolve &Escala.CMS.OptionChoiceResolver.create/2
    end

    field :create_question, :question do
      arg :input, non_null(:question_input)

      resolve &Escala.CMS.QuestionResolver.create/2
    end

    field :create_section, :section do
      arg :input, non_null(:section_input)

      resolve &Escala.CMS.SectionResolver.create/2
    end

    field :create_survey, :survey do
      arg :input, non_null(:survey_input)

      resolve &Escala.CMS.SurveyResolver.create_survey/2
    end

    field :update_survey, :survey do
      arg :id, non_null(:id)
      arg :input, non_null(:survey_input)

      resolve &Escala.CMS.SurveyResolver.update_survey/2
    end
  end
end
