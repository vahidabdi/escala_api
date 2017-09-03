defmodule EscalaWeb.Router do
  use EscalaWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", EscalaWeb do
    pipe_through :api
  end
end
