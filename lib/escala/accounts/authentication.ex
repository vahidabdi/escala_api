defmodule Escala.Accounts.Authentication do
  @moduledoc """
  OAuth2 Authentication
  """
  alias OAuth2.Client
  alias Escala.Accounts

  @uri "https://www.googleapis.com/plus/v1/people/me/openIdConnect"

  def login(provider, code) do
    with {:ok, client} <- get_token(provider, code),
         {:ok, %OAuth2.Response{body: user}} <- get_user!(provider, client),
         user = construct_user(provider, user),
         {:ok, user} = Accounts.find_or_create_user(user) do
      {:ok, user}
    else
      _ ->
        {:error, %{message: "خطا در ورود به سیستم"}}
    end
  end

  defp get_token("google", code), do: Google.get_token(code: code)

  defp get_user!("google", client) do
    Client.get(client, @uri)
  end

  defp construct_user("google", user) do
    email = user["email"]
    first_name = user["given_name"]
    last_name = user["family_name"]
    picture = user["picture"]
    providers = ["google"]

    %{
      email: email,
      first_name: first_name,
      last_name: last_name,
      picture: picture,
      providers: providers
    }
  end
end
