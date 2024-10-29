defmodule Lernmit.Users.User do
  @moduledoc """
  Module for user schema and authentication.
  """
  use Ecto.Schema
  use Pow.Ecto.Schema
  use PowAssent.Ecto.Schema
  alias Lernmit.Participants.Participant
  import Ecto.Changeset

  schema "users" do
    pow_user_fields()
    field :role, :string
    field :locale, :string
    field :name, :string

    timestamps()
  end

  def user_identity_changeset(user_or_changeset, user_identity, attrs, user_id_attrs) do
    user_or_changeset
    |> Ecto.Changeset.cast(attrs, [:role, :locale, :name])
    |> pow_assent_user_identity_changeset(user_identity, attrs, user_id_attrs)
  end

  def admin_changeset(user, attrs, _metadata \\ []) do
    user
    |> cast(attrs, [:email, :role, :locale, :name])
    |> validate_required([])
  end
end
