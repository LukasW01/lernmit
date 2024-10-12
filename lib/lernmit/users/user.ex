defmodule Lernmit.Users.User do
  @moduledoc """
  Module for user schema and authentication.
  """

  use Ecto.Schema
  use Pow.Ecto.Schema
  use PowAssent.Ecto.Schema

  schema "users" do
    pow_user_fields()

    timestamps()
  end
end
