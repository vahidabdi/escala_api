defmodule Escala.SectionResolverTest do
  use EscalaWeb.ConnCase
  import Escala.Factory

  @query """
  query Section($id: ID!) {
    section(id: $id) {
      id
      header
      survey {
        id
      }
    }
  }
  """

  @mutation """
  mutation CreateSection($input: SectionInput!) {
    createSection(input: $input) {
      id
      header
      survey {
        id
      }
    }
  }
  """

  describe "query section" do
    test "returns nil without authorization header" do
      survey = insert(:survey)
      section = insert(:section, survey: survey)

      response =
        build_conn()
        |> graphql_query(
             query: @query,
             variables: %{id: section.id}
           )

      assert response["data"]["section"] == nil
    end

    test "returns section" do
      survey = insert(:survey)
      user = survey.user
      section = insert(:section, survey: survey)

      response =
        build_conn()
        |> authenticate_user(user)
        |> graphql_query(
             query: @query,
             variables: %{id: section.id}
           )

      assert response["data"]["section"]["id"] == section.id
    end
  end

  describe "section mutation" do
    test "creates with valid info" do
      survey = insert(:survey)
      user = survey.user

      response =
        build_conn()
        |> authenticate_user(user)
        |> graphql_query(
             query: @mutation,
             variables: %{input: %{survey_id: survey.id, header: "header"}}
           )

      assert response["data"]["createSection"]["header"] == "header"
      assert response["data"]["createSection"]["survey"]["id"] == survey.id
    end
  end
end
