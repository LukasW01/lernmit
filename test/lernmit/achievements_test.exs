defmodule Lernmit.AchievementsTest do
  use Lernmit.DataCase

  alias Lernmit.Achievements

  describe "achievement" do
    alias Lernmit.Achievements.Achievement

    import Lernmit.AchievementsFixtures

    @invalid_attrs %{title: nil, desc: nil, image: nil}

    test "list_achievement/0 returns all achievement" do
      achievement = achievement_fixture()
      assert Achievements.list_achievement() == [achievement]
    end

    test "get_achievement!/1 returns the achievement with given id" do
      achievement = achievement_fixture()
      assert Achievements.get_achievement!(achievement.id) == achievement
    end

    test "create_achievement/1 with valid data creates a achievement" do
      valid_attrs = %{title: "some title", desc: "some desc", image: "some image"}

      assert {:ok, %Achievement{} = achievement} = Achievements.create_achievement(valid_attrs)
      assert achievement.title == "some title"
      assert achievement.desc == "some desc"
      assert achievement.image == "some image"
    end

    test "create_achievement/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Achievements.create_achievement(@invalid_attrs)
    end

    test "update_achievement/2 with valid data updates the achievement" do
      achievement = achievement_fixture()

      update_attrs = %{
        title: "some updated title",
        desc: "some updated desc",
        image: "some updated image"
      }

      assert {:ok, %Achievement{} = achievement} =
               Achievements.update_achievement(achievement, update_attrs)

      assert achievement.title == "some updated title"
      assert achievement.desc == "some updated desc"
      assert achievement.image == "some updated image"
    end

    test "update_achievement/2 with invalid data returns error changeset" do
      achievement = achievement_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Achievements.update_achievement(achievement, @invalid_attrs)

      assert achievement == Achievements.get_achievement!(achievement.id)
    end

    test "delete_achievement/1 deletes the achievement" do
      achievement = achievement_fixture()
      assert {:ok, %Achievement{}} = Achievements.delete_achievement(achievement)
      assert_raise Ecto.NoResultsError, fn -> Achievements.get_achievement!(achievement.id) end
    end

    test "change_achievement/1 returns a achievement changeset" do
      achievement = achievement_fixture()
      assert %Ecto.Changeset{} = Achievements.change_achievement(achievement)
    end
  end
end
