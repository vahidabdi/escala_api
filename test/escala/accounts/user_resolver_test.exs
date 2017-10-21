defmodule Escala.UserResolverTest do
  use EscalaWeb.ConnCase
  import Escala.Factory

  @query """
  {
    currentUser {
      id
      email
    }
  }
  """

  describe "query currentUser" do
    test "Returns nil without authorization header" do
      response =
        build_conn()
        |> graphql_query(
             query: @query,
             variables: %{}
           )

      assert response["data"]["currentUser"] == nil
    end

    test "Returns current_user" do
      user = insert(:account_user, %{email: "test@demo.com"})

      response =
        build_conn()
        |> authenticate_user(user)
        |> graphql_query(
             query: @query,
             variables: %{}
           )

      assert response["data"]["currentUser"]["email"] == "test@demo.com"
    end
  end
end
