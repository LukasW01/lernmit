defmodule Lernmit.Subjects.Subject do
  @moduledoc """
  Subject schema.
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "subject" do
    field :name, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(subject, attrs) do
    subject
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
