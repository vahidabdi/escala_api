defmodule EscalaWeb.Router do
  use EscalaWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", EscalaWeb do
    pipe_through :api
  end

  forward "/graphql", Absinthe.Plug,
    schema: Escala.Schema

  forward "/graphiql", Absinthe.Plug.GraphiQL,
    schema: Escala.Schema

end
