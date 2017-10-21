defmodule Google do
  @moduledoc """
  An OAuth2 strategy for google
  """
  use OAuth2.Strategy

  alias OAuth2.Strategy.AuthCode
  alias OAuth2.Client

  defp config do
    [
      strategy: __MODULE__,
      site: "https://accounts.google.com",
      authorize_url: "/o/oauth2/auth",
      params: %{scope: "https://www.googleapis.com/auth/userinfo.email"},
      token_url: "/o/oauth2/token"
    ]
  end

  # Public API

  def client do
    conf = Application.get_env(:escala, __MODULE__)

    conf
    |> Keyword.merge(config())
    |> Client.new()
  end

  def authorize_url! do
    Client.authorize_url!(client())
  end

  def get_token(code: code) do
    Client.get_token(
      client(),
      code: code,
      client_secret: client().client_secret
    )
  end

  # Strategy Callbacks

  def authorize_url(client, params) do
    AuthCode.authorize_url(client, params)
  end

  def get_token(client, params, headers) do
    client
    |> put_param(:client_secrect, client.client_secret)
    |> put_header("Accept", "application/json")
    |> AuthCode.get_token(params, headers)
  end
end
