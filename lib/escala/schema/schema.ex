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

    field :create_survey, :survey do
      arg :input, non_null(:create_survey_input)

      resolve &Escala.CMS.SurveyResolver.create_survey/2
    end
  end
end
