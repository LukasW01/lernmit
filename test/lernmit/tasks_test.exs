defmodule Lernmit.TasksTest do
  use Lernmit.DataCase

  alias Lernmit.Tasks

  describe "task" do
    alias Lernmit.Tasks.Task

    import Lernmit.TasksFixtures

    @invalid_attrs %{status: nil, title: nil, text: nil, types: nil, due_date: nil, points: nil}

    test "list_task/0 returns all task" do
      task = task_fixture()
      assert Tasks.list_task() == [task]
    end

    test "get_task!/1 returns the task with given id" do
      task = task_fixture()
      assert Tasks.get_task!(task.id) == task
    end

    test "create_task/1 with valid data creates a task" do
      valid_attrs = %{
        status: "some status",
        title: "some title",
        text: "some text",
        types: "some types",
        due_date: ~D[2024-10-17],
        points: 42
      }

      assert {:ok, %Task{} = task} = Tasks.create_task(valid_attrs)
      assert task.status == "some status"
      assert task.title == "some title"
      assert task.text == "some text"
      assert task.types == "some types"
      assert task.due_date == ~D[2024-10-17]
      assert task.points == 42
    end

    test "create_task/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tasks.create_task(@invalid_attrs)
    end

    test "update_task/2 with valid data updates the task" do
      task = task_fixture()

      update_attrs = %{
        status: "some updated status",
        title: "some updated title",
        text: "some updated text",
        types: "some updated types",
        due_date: ~D[2024-10-18],
        points: 43
      }

      assert {:ok, %Task{} = task} = Tasks.update_task(task, update_attrs)
      assert task.status == "some updated status"
      assert task.title == "some updated title"
      assert task.text == "some updated text"
      assert task.types == "some updated types"
      assert task.due_date == ~D[2024-10-18]
      assert task.points == 43
    end

    test "update_task/2 with invalid data returns error changeset" do
      task = task_fixture()
      assert {:error, %Ecto.Changeset{}} = Tasks.update_task(task, @invalid_attrs)
      assert task == Tasks.get_task!(task.id)
    end

    test "delete_task/1 deletes the task" do
      task = task_fixture()
      assert {:ok, %Task{}} = Tasks.delete_task(task)
      assert_raise Ecto.NoResultsError, fn -> Tasks.get_task!(task.id) end
    end

    test "change_task/1 returns a task changeset" do
      task = task_fixture()
      assert %Ecto.Changeset{} = Tasks.change_task(task)
    end
  end
end
