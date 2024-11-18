defmodule LernmitWeb.LearnsetLive.Show do
  use LernmitWeb, :live_view

  alias Lernmit.Learnsets
  alias Lernmit.Cards
  alias Lernmit.Util.Message

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    case {Learnsets.get_learnset!(id), Cards.list_card(id)} do
      {{:ok, lernset}, cards} ->
        {:noreply,
         socket
         |> assign(:page_title, page_title(socket.assigns.live_action))
         |> assign(:learnset, lernset)
         |> assign(:cards, cards)}

      {{:error, error}, _} ->
        {:noreply,
         socket
         |> put_flash(:error, Message.error(error))
         |> push_navigate(to: "/learnset")}
    end
  end

  defp page_title(:show), do: "Show Learnset"
  defp page_title(:edit), do: "Edit Learnset"
end
