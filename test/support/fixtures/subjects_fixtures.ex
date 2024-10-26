defmodule Lernmit.SubjectsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Lernmit.Subjects` context.
  """

  @doc """
  Generate a subject.
  """
  def subject_fixture(attrs \\ %{}) do
    {:ok, subject} =
      attrs
      |> Enum.into(%{
        name: "English"
      })
      |> Lernmit.Subjects.create_subject()

    subject
  end
end
