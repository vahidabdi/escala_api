defmodule Escala.Schema.Type do
  @moduledoc """
  Graphql Type
  """
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: Escala.Repo

  @desc "The oauth providers"
  enum :providers do
    value :google, as: "google", description: "Google"
    value :linkedin, as: "linkedin", description: "Linkedin"
  end

  @desc "Question type"
  enum :question_type do
    value :short_answer, as: "short answer", description: "Short answer"
    value :long_answer, as: "long answer", description: "Long answer"
    value :multiple_chioce, as: "Multiple Choice", description: "Multiple answer"
  end

  @desc "User profile"
  object :user do
    @desc "user id"
    field :id, :id
    @desc "user email address"
    field :email, :string
    @desc "username"
    field :username, :string
    @desc "first_name"
    field :first_name, :string
    @desc "last_name"
    field :last_name, :string
    @desc "profile picture url"
    field :picture, :string
    @desc "list of providers"
    field :providers, list_of(:providers)
  end

  @desc "User Session"
  object :session do
    @desc "user object"
    field :user, :user
    @desc "user token"
    field :jwt, :string
  end

  @desc "survey"
  object :survey do
    @desc "survey id"
    field :id, :id
    @desc "survey name"
    field :name, :string
    @desc "welcome"
    field :welcome, :string
    @desc "title"
    field :title, :string
    @desc "description"
    field :description, :string
    @desc "user"
    field :user, :user, resolve: assoc(:user)
  end

  # input objects
  @desc "survey input"
  input_object :survey_input do
    field :name, non_null(:string)
    field :welcome, :string
    field :title, :string
    field :description, :string
  end

  @desc "question options"
  input_object :option_input do
    field :option, non_null(:string)
    field :value, :string
  end

  @desc "question input"
  input_object :question_input do
    field :question, non_null(:string)
    field :question_type, non_null(:question_type)
    field :options, list_of(:option_input)
  end

  @desc "create survey input"
  input_object :create_survey_input do
    field :survey_input, non_null(:survey_input)
    field :question_input, list_of(:question_input)
  end
end
