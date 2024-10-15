defmodule Lernmit.AchievementsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Lernmit.Achievements` context.
  """

  @doc """
  Generate a achievement.
  """
  def achievement_fixture(attrs \\ %{}) do
    {:ok, achievement} =
      attrs
      |> Enum.into(%{
        desc: "",
        image: "badge_CreatedFirstSet.svg",
        title: "Set builder"
      })
      |> Lernmit.Achievements.create_achievement()

    achievement
  end
end
