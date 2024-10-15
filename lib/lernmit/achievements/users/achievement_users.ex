defmodule Lernmit.Achievements.Users.AchievementUsers do
  @moduledoc """
  AchievementUsers schema.
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "achievement_users" do
    field :achievement_id, :id
    field :user_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(achievement_users, attrs) do
    achievement_users
    |> cast(attrs, [])
    |> validate_required([])
  end
end
