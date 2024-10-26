defmodule Lernmit.ClassesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Lernmit.Classes` context.
  """

  @doc """
  Generate a class.
  """
  def class_fixture(attrs \\ %{}) do
    {:ok, class} =
      attrs
      |> Enum.into(%{
        name: "9. Klasse"
      })
      |> Lernmit.Classes.create_class()

    class
  end
end
