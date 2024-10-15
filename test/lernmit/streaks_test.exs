defmodule Lernmit.StreaksTest do
  use Lernmit.DataCase

  alias Lernmit.Streaks

  describe "streaks" do
    alias Lernmit.Streaks.Streak

    import Lernmit.StreaksFixtures

    @invalid_attrs %{}

    test "list_streaks/0 returns all streaks" do
      streak = streak_fixture()
      assert Streaks.list_streaks() == [streak]
    end

    test "get_streak!/1 returns the streak with given id" do
      streak = streak_fixture()
      assert Streaks.get_streak!(streak.id) == streak
    end

    test "create_streak/1 with valid data creates a streak" do
      valid_attrs = %{}

      assert {:ok, %Streak{} = streak} = Streaks.create_streak(valid_attrs)
    end

    test "update_streak/2 with valid data updates the streak" do
      streak = streak_fixture()
      update_attrs = %{}

      assert {:ok, %Streak{} = streak} = Streaks.update_streak(streak, update_attrs)
    end

    test "delete_streak/1 deletes the streak" do
      streak = streak_fixture()
      assert {:ok, %Streak{}} = Streaks.delete_streak(streak)
      assert_raise Ecto.NoResultsError, fn -> Streaks.get_streak!(streak.id) end
    end

    test "change_streak/1 returns a streak changeset" do
      streak = streak_fixture()
      assert %Ecto.Changeset{} = Streaks.change_streak(streak)
    end
  end
end
