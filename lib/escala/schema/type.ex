defmodule Escala.Schema.Type do
  @moduledoc """
  Graphql Type
  """
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: Escala.Repo

  @desc "The user providers"
  enum :providers do
    value :google, as: "google", description: "Google"
    value :linkedin, as: "linkedin", description: "Linkedin"
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
end
