defmodule Lernmit.Tasks.Task do
  @moduledoc """
  Task schema.
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "task" do
    field :status, :string, default: "TODO"
    field :title, :string
    field :text, :string
    field :types, :string
    field :due_date, :naive_datetime
    field :points, :integer
    field :course_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:title, :text, :types, :due_date, :points, :course_id])
    |> validate_required([:title, :text, :types, :due_date, :course_id])
  end
end
