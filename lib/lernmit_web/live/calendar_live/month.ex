defmodule LernmitWeb.CalendarLive.Month do
  use LernmitWeb, :live_view

  alias Lernmit.Tasks
  alias Lernmit.Auth.Policy

  import Lernmit.Util.Path
  import LernmitWeb.LernmitComponents

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Calendar")}
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:month_in_view, Date.utc_today())
    |> assign(
      :calendar,
      Tasks.list_task_range(
        socket.assigns.current_user,
        Date.beginning_of_month(Date.utc_today()),
        Date.end_of_month(Date.utc_today())
      )
    )
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  @impl true
  def handle_info({:month_changed, new_month}, socket) do
    {:noreply, assign(socket, month_in_view: new_month)}
  end

  @impl true
  def handle_info(_msg, socket) do
    {:noreply, socket}
  end

  @impl true
  def handle_event("set-date", %{"date" => date}, socket) do
    {:noreply, assign(socket, month_in_view: date)}
  end

  @impl true
  def handle_event("today", _, socket) do
    {:noreply,
     socket
     |> assign(month_in_view: Date.utc_today())
     |> assign(
       :calendar,
       Tasks.list_task_range(
         socket.assigns.current_user,
         Date.beginning_of_month(Date.utc_today()),
         Date.end_of_month(Date.utc_today())
       )
     )}
  end

  @impl true
  def handle_event("previous-month", _, socket) do
    {:noreply, shift_month(socket, -1)}
  end

  @impl true
  def handle_event("next-month", _, socket) do
    {:noreply, shift_month(socket, 1)}
  end

  defp shift_month(socket, direction) do
    boundary =
      if direction > 0,
        do: Date.end_of_month(socket.assigns.month_in_view),
        else: Date.beginning_of_month(socket.assigns.month_in_view)

    socket
    |> assign(month_in_view: Date.add(boundary, direction))
    |> assign(
      :calendar,
      Tasks.list_task_range(
        socket.assigns.current_user,
        Date.beginning_of_month(Date.add(boundary, direction)),
        Date.end_of_month(Date.add(boundary, direction))
      )
    )
  end

  defp month_days(date) do
    Date.range(
      Date.beginning_of_month(date) |> Date.beginning_of_week(:monday),
      Date.end_of_month(date) |> Date.end_of_week(:monday)
    )
  end

  defp day_class(day, month_in_view) do
    if day.month == month_in_view.month do
      # inside current month
      "relative tile"
    else
      # outside current month
      "relative bg-gray-50 dark:bg-gray-700 text-gray-500 dark:text-gray-400"
    end
  end

  def path_class(socket, path) do
    if current_path?(socket, path) do
      # is current path
      "bg-gray-100 dark:bg-gray-700 text-gray-900 dark:text-gray-100"
    else
      # is not current path
      "text-gray-700 dark:text-gray-300"
    end
  end
end
