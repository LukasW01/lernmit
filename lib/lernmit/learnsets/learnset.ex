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

    has_many :cards, Lernmit.Cards.Card, on_replace: :delete

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(learnset, attrs) do
    attrs = cards_json(attrs)

    learnset
    |> cast(attrs, [:title, :desc, :user_id])
    |> validate_required([:title, :user_id])
    |> cast_assoc(:cards, required: true)
  end

  defp cards_json(%{"cards" => cards_json} = attrs) do
    case Jason.decode(cards_json) do
      {:ok, cards} -> Map.put(attrs, "cards", cards)
      _ -> attrs
    end
  end

  defp cards_json(attrs), do: attrs
end
