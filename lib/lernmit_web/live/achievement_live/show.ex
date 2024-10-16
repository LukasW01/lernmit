defmodule LernmitWeb.AchievementLive.Show do
  use LernmitWeb, :live_view

  alias Lernmit.Achievements

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))}
  end

  @impl true
  @spec handle_params(map(), any(), map()) :: {:noreply, map()}
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:achievement, Achievements.get_achievement!(id))
     |> assign(:live_action, :show)}
  end

  defp page_title(:show), do: "Detail Achievement"
end
