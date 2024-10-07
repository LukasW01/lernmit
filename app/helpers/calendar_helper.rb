module CalendarHelper
  def event_position(due_date)
    calendar_start_time = 6 * 60
    calendar_end_time = 20 * 60
    fractions_per_minute = 350.0 / (calendar_end_time - calendar_start_time)

    event_start_minutes = (due_date.hour * 60) + due_date.min - 80
    event_end_minutes = (due_date.hour * 60) + due_date.min - 20

    grid_row_start = ((event_start_minutes - calendar_start_time) * fractions_per_minute).round + 1
    grid_row_span = ((event_end_minutes - event_start_minutes) * fractions_per_minute).round

    [grid_row_start, grid_row_span]
  end
end
