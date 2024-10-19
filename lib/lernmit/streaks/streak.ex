defmodule Lernmit.Streaks.Streak do
  @moduledoc """
  Streak schema.
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "streak" do
    field :user_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(streak, attrs) do
    streak
    |> cast(attrs, [])
    |> validate_required([])
  end
end
