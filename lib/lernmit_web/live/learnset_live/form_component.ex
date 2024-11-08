defmodule LernmitWeb.LearnsetLive.FormComponent do
  use LernmitWeb, :live_component

  alias Lernmit.Learnsets
  alias Lernmit.Cards.Card
  import LernmitWeb.LernmitComponents

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
      </.header>

      <.simple_form for={@form} id="learnset-form" phx-target={@myself} phx-submit="save">
        <.input field={@form[:title]} type="text" label="Title" />
        <.input field={@form[:desc]} type="textarea" label="Desc" />
        <.card cards={@cards} myself={@myself} />
        <:actions>
          <.button phx-disable-with="Saving...">Save Learnset</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  def mount(_params, %{"current_user" => current_user} = _session, socket) do
    {:ok,
     socket
     |> assign(:current_user, current_user)
     |> assign(:title, "New Learnset")}
  end

  @impl true
  def update(%{learnset: learnset, current_user: current_user} = assigns, socket) do
    case learnset.user_id == current_user.id do
      true ->
        {:ok, apply_action(socket, assigns, learnset)}

      false ->
        if learnset.user_id == nil do
          {:ok, apply_action(socket, assigns, learnset)}
        else
          {:error, :unauthorized}
        end
    end
  end

  def apply_action(socket, assigns, learnset) do
    socket
    |> assign(assigns)
    |> assign(:cards, [%Card{id: 1, term: "", definition: ""}])
    |> assign_new(:form, fn ->
      to_form(Learnsets.change_learnset(learnset))
    end)
  end

  @impl true
  def handle_event("validate", %{"learnset" => learnset_params}, socket) do
    changeset = Learnsets.change_learnset(socket.assigns.learnset, learnset_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"learnset" => learnset_params}, socket) do
    save_learnset(socket, socket.assigns.action, learnset_params)
  end

  defp save_learnset(socket, :edit, learnset_params) do
    case Learnsets.update_learnset(socket.assigns.learnset, learnset_params) do
      {:ok, learnset} ->
        notify_parent({:saved, learnset})

        {:noreply,
         socket
         |> put_flash(:info, "Learnset updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_learnset(socket, :new, learnset_params) do
    case Learnsets.create_learnset(learnset_params) do
      {:ok, learnset} ->
        notify_parent({:saved, learnset})

        {:noreply,
         socket
         |> put_flash(:info, "Learnset created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  @impl true
  def handle_event("add-card", _, socket) do
    {:noreply,
     socket
     |> assign(:cards, [
       %Card{id: length(socket.assigns.cards) + 1, term: "", definition: ""}
       | socket.assigns.cards
     ])}
  end

  @impl true
  def handle_event("remove-card", %{"id" => id}, socket) do
    {:noreply,
     socket
     |> assign(:cards, Enum.reject(socket.assigns.cards, &(&1.id == String.to_integer(id))))}
  end

  @impl true
  def handle_event(
        "update-card",
        %{"id" => id, "term" => term, "definition" => definition},
        socket
      ) do
    int_id = String.to_integer(id)

    cards =
      Enum.map(socket.assigns.cards, fn
        %Card{id: ^int_id} = card ->
          %Card{id: card.id, term: term, definition: definition}

        card ->
          card
      end)

    {:noreply, assign(socket, cards: cards)}
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
