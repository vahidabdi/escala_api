defmodule Escala.OptionChoice do
  use EscalaWeb.ConnCase
  import Escala.Factory

  @query """
  query OptionChoice($id: ID!) {
    optionChoice(id: $id) {
      id
      option_choice_name
      option_choice_value
    }
  }
  """

  @mutation """
  mutation CreateOptionChoice($input: OptionChoiceInput) {
    createOptionChoice(input: $input) {
      id
      option_choice_name
      option_choice_value
    }
  }
  """

  describe "query option choice" do
    test "returns nil without auth header" do
      option_choice = insert(:option_choice)

      response =
        build_conn()
        |> graphql_query(
             query: @query,
             variables: %{id: option_choice.id}
           )

      assert response["data"]["optionChoice"] == nil
    end

    test "returns option choice" do
      user = insert(:account_user)
      option_choice = insert(:option_choice)

      response =
        build_conn()
        |> authenticate_user(user)
        |> graphql_query(
             query: @query,
             variables: %{id: option_choice.id}
           )

      assert response["data"]["optionChoice"]["id"] == option_choice.id
    end
  end

  describe "option choice mutation" do
    test "creates with valid attrs" do
      user = insert(:account_user)
      question = insert(:question)

      response =
        build_conn()
        |> authenticate_user(user)
        |> graphql_query(
             query: @mutation,
             variables: %{
               input: %{
                 option_choice_name: "good",
                 option_choice_value: "5",
                 question_id: question.id
               }
             }
           )

      assert response["data"]["createOptionChoice"]["option_choice_name"] == "good"
    end
  end
end
