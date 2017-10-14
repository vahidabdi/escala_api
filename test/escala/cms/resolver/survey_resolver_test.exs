defmodule Escala.SurveyResolverTest do
  use EscalaWeb.ConnCase
  import Escala.Factory

  @surveys """
  query {
    surveys {
      name
      user {
        id
      }
    }
  }
  """
  @survey """
  query Survey($id: ID!){
    survey(id: $id) {
      id
      name
    }
  }
  """
  @create_survey """
  mutation CreateSurvey($input: SurveyInput!) {
    createSurvey(input: $input) {
      id
      name
    }
  }
  """

  describe "query surveys" do
    test "returns list of current_user surveys" do
      user = insert(:account_user)
      _survey = insert(:survey, %{name: "sample survey", user: user})

      response =
        build_conn()
        |> authenticate_user(user)
        |> graphql_query(
          query: @surveys,
          variables: %{}
        )

      assert response["data"]["surveys"] == [%{"name" => "sample survey", "user" => %{"id" => user.id}}]
    end

    test "return nil without authorization header" do
      response =
        build_conn()
        |> graphql_query(
          query: @surveys,
          variables: %{}
        )
      assert response["data"]["surveys"] == nil
    end

  end

  describe "query survey" do
    test "returns nil without authorization header" do
      user = insert(:account_user)
      survey = insert(:survey, %{name: "sample survey", user: user})

      response =
        build_conn()
        |> graphql_query(
          query: @survey,
          variables: %{id: survey.id}
        )
      assert response["data"]["survey"] == nil
    end

    test "returns survey" do
      user = insert(:account_user)
      survey = insert(:survey, %{name: "sample survey", user: user})

      response =
        build_conn()
        |> authenticate_user(user)
        |> graphql_query(
          query: @survey,
          variables: %{id: survey.id}
        )
      assert response["data"]["survey"]["id"] == survey.id
    end
  end

  describe "mutation survey" do
    test "creates a survey with valid info" do
      user = insert(:account_user)

      response =
        build_conn()
        |> authenticate_user(user)
        |> graphql_query(
          query: @create_survey,
          variables: %{input: %{name: "demo"}}
        )

      assert response["data"]["createSurvey"]["name"] == "demo"
    end

    test "returns error without authorization header" do
      response =
        build_conn()
        |> graphql_query(
          query: @create_survey,
          variables: %{input: %{name: "demo"}}
        )

      assert response["data"]["createSurvey"] == nil
    end
  end
end
