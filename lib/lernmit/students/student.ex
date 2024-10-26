defmodule Lernmit.Students.Student do
  @moduledoc """
  Student schema.
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "student" do
    field :user_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(student, attrs) do
    student
    |> cast(attrs, [])
    |> validate_required([])
  end
end
