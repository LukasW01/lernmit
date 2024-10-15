defmodule LernmitWeb.AchievementLive.Index do
  use LernmitWeb, :live_view

  alias Lernmit.Achievements

  @impl true
  @spec mount(any(), any(), Phoenix.LiveView.Socket.t()) :: {:ok, Phoenix.LiveView.Socket.t()}
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :achievement_collection, Achievements.list_achievement())}
  end

  @impl true
  @spec handle_params(any(), any(), map()) :: {:noreply, map()}
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Achievement")
    |> assign(:achievement, nil)
  end
end
