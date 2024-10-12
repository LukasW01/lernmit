defmodule Lernmit.UserIdentities.UserIdentity do
  @moduledoc """
  Module for handling user identities.
  """

  use Ecto.Schema
  use PowAssent.Ecto.UserIdentities.Schema, user: Lernmit.Users.User

  schema "user_identities" do
    pow_assent_user_identity_fields()

    timestamps()
  end
end
