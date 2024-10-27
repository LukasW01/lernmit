defmodule LernmitWeb.CalendarLive.Week do
  use LernmitWeb, :live_view

  alias Lernmit.Tasks
  alias Lernmit.CalendarHelper

  import Lernmit.Util.Path
  import LernmitWeb.LernmitComponents
  import LernmitWeb.Gettext

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Calendar")}
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:week_in_view, Date.utc_today())
    |> assign(:current_user, socket.assigns.current_user)
    |> assign(
      :calendar,
      Tasks.list_task_range(
        socket.assigns.current_user,
        Date.beginning_of_week(Date.utc_today()),
        Date.end_of_week(Date.utc_today())
      )
    )
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  @impl true
  def handle_info({:week_changed, new_week}, socket) do
    {:noreply, assign(socket, week_in_view: new_week)}
  end

  @impl true
  def handle_info(_msg, socket) do
    {:noreply, socket}
  end

  @impl true
  def handle_event("set-date", %{"date" => date}, socket) do
    {:noreply, assign(socket, week_in_view: date)}
  end

  @impl true
  def handle_event("today", _, socket) do
    {:noreply,
     socket
     |> assign(week_in_view: Date.utc_today())
     |> assign(
       :calendar,
       Tasks.list_task_range(
         socket.assigns.current_user,
         Date.beginning_of_week(Date.utc_today()),
         Date.end_of_week(Date.utc_today())
       )
     )}
  end

  @impl true
  def handle_event("previous-week", _, socket) do
    {:noreply, shift_week(socket, -1)}
  end

  @impl true
  def handle_event("next-week", _, socket) do
    {:noreply, shift_week(socket, 1)}
  end

  defp shift_week(socket, direction) do
    boundary =
      if direction > 0,
        do: Date.end_of_week(socket.assigns.week_in_view),
        else: Date.beginning_of_week(socket.assigns.week_in_view)

    socket
    |> assign(week_in_view: Date.add(boundary, direction))
    |> assign(
      :calendar,
      Tasks.list_task_range(
        socket.assigns.current_user,
        Date.beginning_of_week(Date.add(boundary, direction)),
        Date.end_of_week(Date.add(boundary, direction))
      )
    )
  end

  defp week_days(date) do
    Date.range(
      Date.beginning_of_week(date) |> Date.beginning_of_week(:monday),
      Date.end_of_week(date) |> Date.end_of_week(:monday)
    )
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

  def today_class(day) do
    if Date.utc_today() == day do
      # is today
      "inline-flex ml-1.5 h-8 w-8 rounded-full bg-indigo-600 font-semibold text-white"
    else
      # is not today
      "inline-flex ml-1.5 h-8 w-8 rounded-full bg-white dark:bg-gray-800 font-semibold text-gray-900 dark:text-gray-100"
    end
  end
end
