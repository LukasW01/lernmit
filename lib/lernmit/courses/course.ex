defmodule Lernmit.Courses.Course do
  @moduledoc """
  Course schema.
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "course" do
    field :teacher_id, :id
    field :class, :string
    field :subject, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(course, attrs) do
    course
    |> cast(attrs, [:teacher_id, :class, :subject])
    |> validate_required([:teacher_id, :class, :subject])
  end

  def admin_changeset(course, attrs, _metadata \\ []) do
    course
    |> cast(attrs, [:teacher_id, :class, :subject])
    |> validate_required([:teacher_id, :class, :subject])
  end
end
