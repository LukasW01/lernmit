defmodule LernmitWeb.AchievementLive.Index do
  use LernmitWeb, :live_view

  alias Lernmit.Achievements
  alias Lernmit.Achievements.Users
  alias Lernmit.StreakHelper

  @impl true
  @spec mount(any(), any(), Phoenix.LiveView.Socket.t()) :: {:ok, Phoenix.LiveView.Socket.t()}
  def mount(_, _, socket) do
    {:ok,
     socket
     |> assign(:page_title, "Achievement")
     |> assign(:show, false)}
  end

  @impl true
  @spec handle_params(any(), any(), map()) :: {:noreply, map()}
  def handle_params(params, _, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:achievements, Achievements.list_achievement())
    |> assign(:achievement_user, Users.list_achievement_users(socket.assigns.current_user.id))
    |> assign(:streak, StreakHelper.streaks(socket.assigns.current_user.id))
  end

  @impl true
  def handle_event("show", %{"id" => achievement_id}, socket) do
    achievement =
      Enum.find(socket.assigns.achievements, &(&1.id == String.to_integer(achievement_id)))

    {:noreply,
     socket
     |> assign(:show, true)
     |> assign(:selected_achievement, achievement)
     |> assign(
       :locked,
       Enum.member?(
         Enum.map(socket.assigns.achievement_user, & &1.achievement_id),
         achievement.id
       )
     )}
  end

  @impl true
  def handle_event("cancel", _, socket) do
    {:noreply, assign(socket, :show, false)}
  end
end
