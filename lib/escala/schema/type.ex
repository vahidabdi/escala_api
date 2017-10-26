defmodule Escala.Schema.Type do
  @moduledoc """
  Graphql Type
  """
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: Escala.Repo

  @desc "The oauth providers"
  enum :providers do
    value(:google, as: "google", description: "Google")
  end

  @desc "User profile"
  object :user do
    @desc "user id"
    field(:id, :id)

    @desc "user email address"
    field(:email, :string)

    @desc "username"
    field(:username, :string)

    @desc "first_name"
    field(:first_name, :string)

    @desc "last_name"
    field(:last_name, :string)

    @desc "profile picture url"
    field(:picture, :string)

    @desc "list of providers"
    field(:providers, list_of(:providers))
  end

  @desc "User Session"
  object :session do
    @desc "user object"
    field(:user, :user)

    @desc "user token"
    field(:jwt, :string)
  end

  @desc "option group"
  object :option_group do
    @desc "option group id"
    field(:id, :id)

    @desc "name"
    field(:name, :string)

    @desc "user"
    field(:user, :user, resolve: assoc(:user))

    @desc "option choices"
    field(:option_choices, list_of(:option_choice), resolve: assoc(:option_choices))
  end

  @desc "option choice"
  object :option_choice do
    @desc "option choice id"
    field(:id, :id)

    @desc "option choice name"
    field(:option_choice_name, :string)

    @desc "option choice value"
    field(:option_choice_value, :string)

    @desc "option group"
    field(:option_group, :option_group, resolve: assoc(:option_group))

    @desc "question options"
    field(:question_options, list_of(:question_option), resolve: assoc(:question_options))
  end

  @desc "question option"
  object :question_option do
    @desc "question option id"
    field(:id, :id)

    @desc "question"
    field(:question, :question, resolve: assoc(:question))

    @desc "option choice"
    field(:option_choice, :option_choice, resolve: assoc(:option_choice))
  end

  @desc "input type"
  object :input_type do
    @desc "input type id"
    field(:id, :id)

    @desc "name"
    field(:name, :string)

    @desc "has option"
    field(:has_option, :boolean)
  end

  @desc "Survey Section"
  object :section do
    @desc "section id"
    field(:id, :id)

    @desc "section header"
    field(:header, :string)

    @desc "section sub_header"
    field(:sub_header, :string)

    @desc "survey"
    field(:survey, :survey, resolve: assoc(:survey))

    @desc "questions"
    field(:questions, list_of(:question), resolve: assoc(:questions))
  end

  @desc "question"
  object :question do
    @desc "question id"
    field(:id, :id)

    @desc "question text"
    field(:question_text, :string)

    @desc "question subtext"
    field(:question_subtext, :string)

    @desc "allow multiple option"
    field(:allow_multiple_option, :boolean)

    @desc "answer required"
    field(:answer_required, :boolean)

    @desc "input type"
    field(:input_type, :input_type, resolve: assoc(:input_type))

    @desc "survey"
    field(:survey, :survey, resolve: assoc(:survey))

    @desc "question options"
    field(:question_options, list_of(:question_option), resolve: assoc(:question_options))

    @desc "question position"
    field(:position, :integer)
  end

  @desc "survey"
  object :survey do
    @desc "survey id"
    field(:id, :id)

    @desc "survey name"
    field(:name, :string)

    @desc "welcome"
    field(:welcome, :string)

    @desc "title"
    field(:title, :string)

    @desc "description"
    field(:description, :string)

    @desc "user"
    field(:user, :user, resolve: assoc(:user))

    @desc "sections"
    field(:sections, list_of(:section), resolve: assoc(:sections))
  end

  # input objects

  @desc "option group input"
  input_object :option_group_input do
    field(:name, non_null(:string))
  end

  @desc "option choice input"
  input_object :option_choice_input do
    field(:option_choice_name, non_null(:string))
    field(:option_choice_value, non_null(:string))
    field(:option_group_id, non_null(:id))
  end

  @desc "section input"
  input_object :section_input do
    field(:survey_id, non_null(:id))
    field(:header, non_null(:string))
    field(:sub_header, :string)
    field(:questions_input, list_of(:question_input))
  end

  @desc "question input"
  input_object :question_input do
    field(:question_text, non_null(:string))
    field(:question_subtext, :string)
    field(:allow_multiple_option, :boolean)
    field(:answer_required, :boolean)
    field(:input_type_id, non_null(:id))
    field(:survey_id, non_null(:id))
    field(:position, non_null(:integer))
  end

  @desc "survey input"
  input_object :survey_input do
    field(:name, non_null(:string))
    field(:welcome, :string)
    field(:title, :string)
    field(:description, :string)
  end
end
