defmodule Lernmit.ParticipantsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Lernmit.Participants` context.
  """

  @doc """
  Generate a participant.
  """
  def participant_fixture(attrs \\ %{}) do
    {:ok, participant} =
      attrs
      |> Enum.into(%{
        student_id: 1,
        course_id: 1
      })
      |> Lernmit.Participants.create_participant()

    participant
  end
end
