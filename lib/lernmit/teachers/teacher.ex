defmodule Lernmit.Teachers.Teacher do
  @moduledoc """
  Teacher schema.
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "teacher" do
    field :user_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(teacher, attrs) do
    teacher
    |> cast(attrs, [])
    |> validate_required([])
  end
end
