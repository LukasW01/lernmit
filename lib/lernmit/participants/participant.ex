defmodule Lernmit.Participants.Participant do
  @moduledoc """
  Participant schema.
  """
  use Ecto.Schema

  import Ecto.Changeset

  schema "participant" do
    field :course_id, :id
    field :student_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(participant, attrs) do
    participant
    |> cast(attrs, [:course_id, :student_id])
    |> validate_required([:course_id, :student_id])
  end

  def admin_changeset(participant, attrs, _metadata \\ []) do
    participant
    |> cast(attrs, [:course_id, :student_id])
    |> validate_required([:course_id, :student_id])
  end
end
