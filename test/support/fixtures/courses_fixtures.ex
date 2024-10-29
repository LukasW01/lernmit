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
        class: "Klasse 8",
        subject: "English",
        teacher_id: 1
      })
      |> Lernmit.Courses.create_course()

    course
  end
end
