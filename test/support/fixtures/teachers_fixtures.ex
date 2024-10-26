defmodule Lernmit.TeachersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Lernmit.Teachers` context.
  """

  @doc """
  Generate a teacher.
  """
  def teacher_fixture(attrs \\ %{}) do
    {:ok, teacher} =
      attrs
      |> Enum.into(%{
        user_id: 1
      })
      |> Lernmit.Teachers.create_teacher()

    teacher
  end
end
