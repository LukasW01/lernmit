defmodule Lernmit.CoursesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Lernmit.Courses` context.
  """

  @doc """
  Generate a course.
  """
  def course_fixture(attrs \\ %{}) do
    {:ok, course} =
      attrs
      |> Enum.into(%{
        student_id: 1,
        teacher_id: 1,
        class_id: 1,
        subject_id: 1,
        task_id: 1
      })
      |> Lernmit.Courses.create_course()

    course
  end
end
