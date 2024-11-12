defimpl Jason.Encoder, for: Lernmit.Cards.Card do
  def encode(%Lernmit.Cards.Card{term: term, definition: definition}, opts) do
    Jason.Encode.map(%{term: term, definition: definition}, opts)
  end
end
