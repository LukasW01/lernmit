defmodule Lernmit.StreakFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Lernmit.Streaks` context.
  """

  @doc """
  Generate a streak.
  """
  def streak_fixture(attrs \\ %{}) do
    {:ok, streak} =
      attrs
      |> Enum.into(%{
        user_id: 1
      })
      |> Lernmit.Streaks.create_streak()

    streak
  end
end
