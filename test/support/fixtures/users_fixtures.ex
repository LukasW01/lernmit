defmodule Lernmit.Achievements.UsersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Lernmit.Achievements.Users` context.
  """

  @doc """
  Generate a achievement_users.
  """
  def achievement_users_fixture(attrs \\ %{}) do
    {:ok, achievement_users} =
      attrs
      |> Enum.into(%{
        achievement_id: 1,
        user_id: 1
      })
      |> Lernmit.Achievements.Users.create_achievement_users()

    achievement_users
  end
end
