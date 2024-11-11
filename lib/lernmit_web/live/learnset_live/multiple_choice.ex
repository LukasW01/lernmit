defmodule LernmitWeb.LearnsetLive.MultipleChoice do
  use LernmitWeb, :live_view

  alias Lernmit.Learnsets
  alias Lernmit.Cards
  alias Lernmit.Streaks
  alias Lernmit.Util.Message

  defstruct option: [], answer: nil

  @impl true
  def mount(%{"id" => id}, _session, socket) do
    case {Learnsets.get_learnset!(id), Cards.list_card(id)} do
      {{:ok, lernset}, cards} ->
        {:ok,
         socket
         |> assign(:nav, :fullscreen)
         |> assign(:cards, cards)
         |> assign(:learnset, lernset)
         |> assign(:current_card, Enum.at(cards, 0))
         |> assign(:length, length(cards))
         |> assign(:index, 1)
         |> assign(:percentage, 0)
         |> assign(:multiple_choice, options(cards, Enum.at(cards, 0)))
         |> assign(:selected, nil)}

      {{:error, error}, []} ->
        {:ok,
         socket
         |> put_flash(:error, Message.error(error))
         |> push_navigate(to: "/learnset")}
    end
  end

  @impl true
  def handle_event("select", %{"id" => id}, socket) do
    unless socket.assigns.selected do
      Process.send_after(self(), :next_card, 1000)
    end

    {:noreply,
     socket
     |> assign(:selected, socket.assigns.current_card.id == String.to_integer(id))}
  end

  @impl true
  def handle_info(:next_card, socket) do
    if socket.assigns.index == socket.assigns.length do
      Streaks.create_streak(%{user_id: socket.assigns.current_user.id})

      {:noreply,
       socket
       |> put_flash(:info, "You have completed the learnset")
       |> redirect(to: "/learnset/#{socket.assigns.learnset.id}")}
    else
      {:noreply,
       socket
       |> assign(:current_card, shift_card(socket.assigns, 1))
       |> assign(:percentage, calc_percentage(socket.assigns))
       |> assign(:index, socket.assigns.index + 1)
       |> assign(:multiple_choice, options(socket.assigns.cards, shift_card(socket.assigns, 1)))
       |> assign(:selected, nil)}
    end
  end

  defp options(cards, current_card) do
    options =
      cards
      |> Enum.reject(&(&1.id == current_card.id))
      |> Enum.take_random(2)
      |> Enum.concat([current_card])
      |> Enum.shuffle()

    %__MODULE__{option: options, answer: current_card.id}
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

  defp class_answer(id, current_card, selected) do
    if selected == nil do
      "ring-gray-300 dark:ring-gray-600 hover:shadow-lg dark:hover:shadow-gray-700"
    else
      if current_card.id == id do
        "ring-green-500 hover:shadow-green-500"
      else
        "ring-red-500 hover:shadow-red-500"
      end
    end
  end
end
