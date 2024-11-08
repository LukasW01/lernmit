defmodule LernmitWeb.LearnsetLive.Flashcard do
  use LernmitWeb, :live_view

  alias Lernmit.Learnsets
  alias Lernmit.Cards

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    cards = Cards.list_card(id)

    {:ok,
     socket
     |> assign(:cards, cards)
     |> assign(:current_card, Enum.at(cards, 0))
     |> assign(:index, 0)
     |> assign(:length, length(cards))
     |> assign(:learnset, Learnsets.get_learnset!(id))
     |> assign(:percentage, 0)
     |> assign(:nav, :fullscreen)}
  end

  @impl true
  def handle_event("next-card", _, socket) do
    {:noreply,
     socket
     |> assign(:current_card, shift_card(socket.assigns, 1))
     |> assign(:percentage, calc_percentage(socket.assigns))
     |> assign(:index, socket.assigns.index + 1)}
  end

  @impl true
  def handle_event("prev-card", _, socket) do
    {:noreply,
     socket
     |> assign(:current_card, shift_card(socket.assigns, -1))
     |> assign(:percentage, calc_percentage(socket.assigns))
     |> assign(:index, socket.assigns.index - 1)}
  end

  @impl true
  def handle_event("randomize", _, socket) do
    with shuffled_cards <- shuffle_cards(socket.assigns) do
      {:noreply,
       socket
       |> assign(:cards, shuffled_cards)
       |> assign(:current_card, Enum.at(shuffled_cards, socket.assigns.index))}
    end
  end

  defp shift_card(assigns, shift) do
    case Enum.find_index(assigns.cards, &(&1.id == assigns.current_card.id)) do
      index when index + shift >= 0 and index + shift < length(assigns.cards) ->
        Enum.at(assigns.cards, index + shift)

      _ ->
        assigns.current_card
    end
  end

  defp calc_percentage(assigns) do
    case Enum.find_index(assigns.cards, &(&1.id == assigns.current_card.id)) do
      index -> (index + 1) / length(assigns.cards) * 100
    end
  end

  defp shuffle_cards(%{cards: cards, current_card: current_card}) do
    {viewed, unviewed} =
      cards
      |> Enum.split_while(&(&1.id != current_card.id))

    viewed ++ Enum.shuffle(unviewed)
  end
end
