defmodule Lernmit.StreakHelper do
  @moduledoc """
  Helper functions for calculating streaks.
  """
  alias Lernmit.Streak
  alias Lernmit.Streaks

  @doc """
  Calculates a daily streak for a given user. A streak is defined as having at least
  one streak entry in consecutive days.

  ## Example

      iex> streak_daily(123)
      3
  """
  @spec streak_daily(integer) :: integer
  def streak_daily(user_id) do
    dates =
      Streaks.list_streaks(user_id)
      |> Enum.map(& &1.inserted_at)
      |> Enum.map(&DateTime.to_date/1)

    if dates != [] do
      dates
      |> Enum.map(& &1.day)
      |> Enum.uniq()
      |> Enum.count()
    else
      0
    end
  end

  @doc """
  Calculates a weekly streak for a given user. A streak is defined as having at least
  one streak entry in consecutive weeks.
  """
  @spec streak_weekly(integer) :: integer
  def streak_weekly(user_id) do
    dates =
      Streaks.list_streaks(user_id)
      |> Enum.map(& &1.inserted_at)
      |> Enum.map(&DateTime.to_date/1)
      # Avoid duplicates in the same week
      |> Enum.uniq_by(&Date.beginning_of_week(&1))
      # Ensure the dates are sorted in order
      |> Enum.sort()

    if dates != [] do
      ## TODO: Implement weekly streak calculation
    else
      0
    end
  end
end
