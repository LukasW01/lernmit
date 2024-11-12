defmodule LernmitWeb.LearnsetLive.Index do
  use LernmitWeb, :live_view

  alias Lernmit.Learnsets
  alias Lernmit.Learnsets.Learnset

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:learnset_collection, Learnsets.list_learnset())
     |> assign(:current_user, socket.assigns.current_user)}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    case Learnsets.get_learnset!(id) do
      {:ok, learnset} ->
        socket
        |> assign(:page_title, "Edit Learnset")
        |> assign(:learnset, learnset)

      {:error, _} ->
        socket
        |> put_flash(:error, "Learnset not found")
        |> push_navigate(to: "/learnset")
    end
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
    {:noreply,
     assign(socket,
       learnset_collection: [
         learnset | Enum.reject(socket.assigns.learnset_collection, &(&1.id == learnset.id))
       ]
     )}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    case Learnsets.get_learnset!(id) do
      {:ok, learnset} ->
        {:ok, _} = Learnsets.delete_learnset(socket.assigns.current_user, learnset)

        {:noreply,
         assign(socket,
           learnset_collection:
             Enum.reject(socket.assigns.learnset_collection, &(&1.id == learnset.id))
         )}

      {:error, _} ->
        {:noreply, put_flash(socket, :error, "Learnset not found")}
    end
  end
end
