defmodule Lernmit.AuthProvider do
  @moduledoc """
  Defines the authentication provider and is responsible for handling authentication with the OAuth2 provider.
  """
  use Assent.Strategy.OAuth2.Base

  @impl true
  def default_config(_config) do
    [
      base_url: System.get_env("OAUTH_BASE_URL"),
      authorize_url: "/protocol/openid-connect/auth",
      token_url: "/protocol/openid-connect/token",
      user_url: "/protocol/openid-connect/userinfo",
      authorization_params: [scope: "email openid profile"],
      auth_method: :client_secret_post
    ]
  end

  @impl true
  def normalize(_config, user) do
    {:ok,
     %{
       "sub" => user["sub"],
       "name" => user["name"],
       "nickname" => user["username"],
       "email" => user["email"]
     }}
  end
end
