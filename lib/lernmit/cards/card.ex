defmodule Lernmit.Cards.Card do
  @moduledoc """
  The Card schema.
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "card" do
    field :term, :string
    field :definition, :string
    field :learnset_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(card, attrs) do
    card
    |> cast(attrs, [:term, :definition, :learnset_id])
    |> validate_required([:term, :definition])
  end
end
