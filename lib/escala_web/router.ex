defmodule EscalaWeb.Router do
  use EscalaWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.LoadResource
    plug EscalaWeb.Plug.Context
  end

  if Mix.env == :dev do
    scope "/graphiql" do
      pipe_through :api

      forward "/", Absinthe.Plug.GraphiQL,
        schema: Escala.Schema
    end
  end

  scope "/api" do
    pipe_through :api

    forward "/", Absinthe.Plug,
      schema: Escala.Schema
  end
end
