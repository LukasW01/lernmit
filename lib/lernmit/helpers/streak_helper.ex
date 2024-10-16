defmodule Lernmit.StreakHelper do
  @moduledoc """
  Helper functions for calculating streaks.
  """
  alias Lernmit.Streaks

  defstruct daily: 0, weekly: 0

  @doc """
  Calculates a daily & weekly streak for a given user.

  streak_daily/1 returns the number of days a user has achieved a daily streak. A daily streak is defined as having at least one streak entry in consecutive days.  
      iex> streak_daily([%Streak{inserted_at: ~N[2024-10-01 00:00:00]}, %Streak{inserted_at: ~N[2024-10-02 00:00:00]}])
      2

  streak_weekly/1 returns the number of weeks a user has achieved a weekly streak. A weekly streak is defined as having at least one streak entry in consecutive weeks.  
      iex> streak_weekly([%Streak{inserted_at: ~N[2024-10-01 00:00:00]}, %Streak{inserted_at: ~N[2024-09-23 00:00:00]}])
      2

    ## Example
     iex> streaks(123)
     %Lernmit.StreakHelper{daily: 2, weekly: 1}
  """
  def streaks(user_id) do
    dates = Streaks.list_streaks(user_id)

    %__MODULE__{daily: streak_daily(dates), weekly: streak_weekly(dates)}
  end

  @spec streak_daily(list) :: integer
  defp streak_daily(dates) do
    dates =
      dates
      |> Enum.map(& &1.inserted_at)
      |> Enum.map(&DateTime.to_date/1)

    unless Enum.empty?(dates) do
      dates
      |> Enum.map(& &1.day)
      |> Enum.uniq()
      |> Enum.count()
    end
  end

  @spec streak_weekly(list) :: integer
  defp streak_weekly(dates) do
    dates =
      dates
      |> Enum.map(& &1.inserted_at)
      |> Enum.map(&DateTime.to_date/1)
      |> Enum.uniq_by(&Date.beginning_of_week(&1))
      |> Enum.sort()

    unless Enum.empty?(dates) do
      dates
      |> Enum.map(& &1.day)
      |> Enum.uniq()
      |> Enum.count()
    end
  end
end
