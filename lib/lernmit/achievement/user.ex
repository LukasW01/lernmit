defmodule Lernmit.Achievement.User do
  @moduledoc """
  Achievement user schema.
  This schema is used to link users to achievements.
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "achievement_user" do
    field :achievement_id, :id
    field :user_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [])
    |> validate_required([])
  end
end
