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

  defp apply_action(socket, :index, _) do
    socket
    |> assign(:achievements, Achievements.list_achievement())
    |> assign(:achievement_user, Users.list_achievement_users(socket.assigns.current_user.id))
    |> assign(:streak_daily, StreakHelper.streak_daily(socket.assigns.current_user.id))
    |> assign(:streak_weekly, StreakHelper.streak_weekly(socket.assigns.current_user.id))
  end
end
