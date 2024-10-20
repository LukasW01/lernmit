defmodule Lernmit.CalendarHelper do
  @moduledoc """
  Helper functions for working with calendars.
  """

  @doc """
  Returns the position of an event in the calendar.
  """
  def event_position(due_date) do
    calendar_start_time = 6 * 60
    calendar_end_time = 20 * 60
    fractions_per_minute = 350.0 / (calendar_end_time - calendar_start_time)

    event_start_minutes = due_date.hour * 60 + due_date.minute - 80
    event_end_minutes = due_date.hour * 60 + due_date.minute - 20

    grid_row_start = round((event_start_minutes - calendar_start_time) * fractions_per_minute) + 1
    grid_row_span = round((event_end_minutes - event_start_minutes) * fractions_per_minute)

    {grid_row_start, grid_row_span}
  end
end
