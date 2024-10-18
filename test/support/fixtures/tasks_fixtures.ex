defmodule Lernmit.TasksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Lernmit.Tasks` context.
  """

  @doc """
  Generate a task.
  """
  def task_fixture(attrs \\ %{}) do
    {:ok, task} =
      attrs
      |> Enum.into(%{
        due_date: ~D[2024-10-17],
        points: 42,
        status: "some status",
        text: "some text",
        title: "some title",
        types: "some types"
      })
      |> Lernmit.Tasks.create_task()

    task
  end
end
