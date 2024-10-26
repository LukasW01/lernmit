defmodule Lernmit.StudentsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Lernmit.Students` context.
  """

  @doc """
  Generate a student.
  """
  def student_fixture(attrs \\ %{}) do
    {:ok, student} =
      attrs
      |> Enum.into(%{
        user_id: 1
      })
      |> Lernmit.Students.create_student()

    student
  end
end
