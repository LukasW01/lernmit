defmodule LernmitWeb.LearnsetLive.Index do
  use LernmitWeb, :live_view

  alias Lernmit.Learnsets
  alias Lernmit.Learnsets.Learnset
  alias Lernmit.Cards.Card
  alias Lernmit.Cards
  import LernmitWeb.LernmitComponents

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> stream(:learnset_collection, Learnsets.list_learnset())
     |> assign(:current_user, socket.assigns.current_user)}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Learnset")
    |> assign(:learnset, Learnsets.get_learnset!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Learnset")
    |> assign(:learnset, %Learnset{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Learnset")
    |> assign(:learnset, nil)
  end

  @impl true
  def handle_info({LernmitWeb.LearnsetLive.FormComponent, {:saved, learnset}}, socket) do
    {:noreply, stream_insert(socket, :learnset_collection, learnset)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    learnset = Learnsets.get_learnset!(id)
    {:ok, _} = Learnsets.delete_learnset(learnset)

    {:noreply, stream_delete(socket, :learnset_collection, learnset)}
  end
end
