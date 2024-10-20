defmodule Lernmit.Tasks.Task do
  @moduledoc """
  Task schema.
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "task" do
    field :status, :string
    field :title, :string
    field :text, :string
    field :types, :string
    field :due_date, :naive_datetime
    field :points, :integer
    field :user_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:title, :text, :status, :types, :due_date, :points])
    |> validate_required([:title, :text, :status, :types, :due_date, :points])
  end
end
