defmodule Lernmit.Learnsets.Learnset do
  @moduledoc """
  The Learnset schema.
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "learnset" do
    field :title, :string
    field :desc, :string
    field :user_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(learnset, attrs) do
    learnset
    |> cast(attrs, [:title, :desc, :user_id])
    |> validate_required([:title, :user_id])
  end
end
