defmodule LernmitWeb.CalendarLive.Index do
  use LernmitWeb, :live_view

  alias Lernmit.Tasks
  alias Lernmit.Tasks.Task

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :task, Tasks.list_task())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Calendar")
    |> assign(:calendar, nil)
  end
end
