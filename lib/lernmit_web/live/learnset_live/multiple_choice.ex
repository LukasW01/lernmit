defmodule LernmitWeb.LearnsetLive.MultipleChoice do
  use LernmitWeb, :live_view

  alias Lernmit.Learnsets
  alias Lernmit.Learnsets.Learnset
  alias Lernmit.Cards
  import LernmitWeb.LernmitComponents

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
     |> assign(:nav, true)}
  end

  @impl true
  def handle_event("next-card", _, socket) do
    {:noreply,
     socket
     |> assign(:current_card, shift_card(socket.assigns, 1))
     |> assign(:percentage, calc_percentage(socket.assigns))
     |> assign(:index, socket.assigns.index + 1)}
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
end
