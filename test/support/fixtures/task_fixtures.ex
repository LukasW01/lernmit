defmodule Lernmit.TaskFixtures do
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
        # https://www.urbandictionary.com/define.php?term=42
        points: 42,
        status: "DONE",
        text:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. In gravida justo et nulla efficitur, maximus egestas sem pellentesque. Lorem ipsum dolor sit amet, consectetur adipiscing elit. In gravida justo et nulla efficitur, maximus egestas sem pellentesque.",
        title: "Math exercise",
        types: "EXERCISE",
        course_id: 1
      })
      |> Lernmit.Tasks.create_task()

    task
  end
end
