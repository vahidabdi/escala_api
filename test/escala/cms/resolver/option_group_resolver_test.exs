defmodule Escala.OptionGroupResolverTest do
  use EscalaWeb.ConnCase
  import Escala.Factory

  @query """
  query OptionGroup($id: ID!) {
    optionGroup(id: $id) {
      id
      name
      user {
        id
      }
    }
  }
  """

  @mutation """
  mutation CreateOptionGroup($input: OptionGroupInput!) {
    createOptionGroup(input: $input) {
      name
      user {
        id
      }
    }
  }
  """

  describe "query option group" do
    test "returns nil without authorization header" do
      user = insert(:account_user)
      option_group = insert(:option_group, user: user)

      response =
        build_conn()
        |> graphql_query(
          query: @query,
          variables: %{id: option_group.id}
        )

      assert response["data"]["optionGroup"] == nil
    end

    test "returns option group" do
      user = insert(:account_user)
      option_group = insert(:option_group, user: user)

      response =
        build_conn()
        |> authenticate_user(user)
        |> graphql_query(
          query: @query,
          variables: %{id: option_group.id}
        )

        assert response["data"]["optionGroup"]["id"] == option_group.id
        assert response["data"]["optionGroup"]["user"]["id"] == user.id
    end
  end

  describe "option group mutation" do
    test "creates with valid info" do
      user = insert(:account_user)

      response =
        build_conn()
        |> authenticate_user(user)
        |> graphql_query(
        query: @mutation,
        variables: %{input: %{name: "option group1"}}
      )

      assert response["data"]["createOptionGroup"]["name"] == "option group1"
      assert response["data"]["createOptionGroup"]["user"]["id"] == user.id

    end
  end

end
