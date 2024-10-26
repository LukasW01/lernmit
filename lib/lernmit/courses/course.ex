defmodule Lernmit.Courses.Course do
  @moduledoc """
  Course schema.
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "course" do
    field :student_id, :id
    field :teacher_id, :id
    field :class_id, :id
    field :subject_id, :id
    field :task_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(course, attrs) do
    course
    |> cast(attrs, [])
    |> validate_required([])
  end
end
