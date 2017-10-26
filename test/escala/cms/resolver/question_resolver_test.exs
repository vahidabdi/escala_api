defmodule Escala.QuestionResolverTest do
  use EscalaWeb.ConnCase
  import Escala.Factory

  @query """
  query GetQuestion($id: ID!) {
    question(id: $id) {
      id
      question_text
    }
  }
  """

  @mutation """
  mutation CreateQuestion($input: QuestionInput!) {
    createQuestion(input: $input) {
      id
      question_text
    }
  }
  """

  describe "query question" do
    test "returns nil without authorization header" do
      question = insert(:question)

      response =
        build_conn()
        |> graphql_query(
             query: @query,
             variables: %{id: question.id}
           )

      assert response["data"]["question"] == nil
    end
  end

  test "returns question" do
    question = insert(:question)
    user = question.survey.user

    response =
      build_conn()
      |> authenticate_user(user)
      |> graphql_query(
           query: @query,
           variables: %{id: question.id}
         )

    assert response["data"]["question"]["id"] == question.id
  end

  describe "question mutation" do
    test "creates with valid info" do
      input_type = insert(:input_type)
      survey = insert(:survey)
      user = survey.user

      response =
        build_conn()
        |> authenticate_user(user)
        |> graphql_query(
             query: @mutation,
             variables: %{
               input: %{
                 input_type_id: input_type.id,
                 question_text: "What's your name?",
                 survey_id: survey.id,
                 position: 1,
               }
             }
           )

      assert response["data"]["createQuestion"]["question_text"] == "What's your name?"
    end
  end
end
