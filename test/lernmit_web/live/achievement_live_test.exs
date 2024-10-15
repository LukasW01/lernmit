defmodule LernmitWeb.AchievementLiveTest do
  use LernmitWeb.ConnCase

  import Phoenix.LiveViewTest
  import Lernmit.AchievementsFixtures

  defp create_achievement(_) do
    achievement = achievement_fixture()
    %{achievement: achievement}
  end

  describe "Index" do
    setup [:create_achievement]

    test "lists all achievement", %{conn: conn, achievement: achievement} do
      {:ok, _index_live, html} = live(conn, ~p"/achievement")

      assert html =~ achievement.title
    end
  end

  describe "Show" do
    setup [:create_achievement]

    test "displays achievement", %{conn: conn, achievement: achievement} do
      {:ok, _show_live, html} = live(conn, ~p"/achievement/#{achievement}")

      assert html =~ achievement.title
    end
  end
end
