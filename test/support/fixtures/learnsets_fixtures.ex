defmodule Lernmit.LearnsetsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Lernmit.Learnsets` context.
  """

  @doc """
  Generate a learnset.
  """
  def learnset_fixture(attrs \\ %{}) do
    {:ok, learnset} =
      attrs
      |> Enum.into(%{
        desc: "desc",
        title: "title"
      })
      |> Lernmit.Learnsets.create_learnset()

    learnset
  end
end
