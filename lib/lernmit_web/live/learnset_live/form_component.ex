defmodule LernmitWeb.LearnsetLive.FormComponent do
  use LernmitWeb, :live_component

  alias Lernmit.Learnsets
  alias Lernmit.Cards
  import LernmitWeb.LernmitComponents

  @impl true
  def render(assigns) do
    ~H"""
    <div
      x-data="{ cards: [{ term: '', definition: '' }] }"
      x-init={"
          fetch('/cards/#{@learnset.id}')
            .then(response => response.json())
            .then(data => cards = data)
            .catch(error => console.error('Error:', error))
      "}
    >
      <.header>
        {@title}
      </.header>

      <.simple_form
        for={@form}
        id="learnset-form"
        phx-target={@myself}
        phx-submit="save"
        phx-change="validate"
      >
        <.input field={@form[:title]} type="text" label="Title" />
        <.input field={@form[:desc]} type="textarea" label="Desc" />
        <input type="hidden" name="learnset[cards]" x-model="JSON.stringify(cards)" />
        <.card learnset={@learnset} />
        <:actions>
          <div class="ml-auto mt-6 flex items-center justify-end gap-x-6">
            <.simple_button
              phx-click={JS.navigate(~p"/learnset")}
              class="text-sm/6 font-semibold text-gray-900 dark:text-white"
            >
              Cancel
            </.simple_button>
            <.button phx-disable-with="Saving...">
              Save
            </.button>
          </div>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:title, "New Learnset")}
  end

  @impl true
  def update(%{learnset: learnset, current_user: current_user} = assigns, socket) do
    case learnset.user_id == current_user.id do
      true ->
        apply_action(assigns, socket, :edit)

      false ->
        if learnset.user_id == nil do
          apply_action(assigns, socket, :new)
        else
          {:error, :unauthorized}
        end
    end
  end

  def apply_action(%{learnset: learnset, current_user: current_user} = assigns, socket, :new) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign(:current_user, current_user)
     |> assign_new(:form, fn ->
       to_form(Learnsets.change_learnset(learnset))
     end)}
  end

  def apply_action(%{learnset: learnset} = assigns, socket, :edit) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Learnsets.change_learnset(learnset))
     end)}
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
    case Learnsets.update_learnset(
           socket.assigns.current_user,
           socket.assigns.learnset,
           learnset_params
         ) do
      {:ok, learnset} ->
        notify_parent({:saved, learnset})

        learnset_params["cards"]
        |> Jason.decode!()
        |> Enum.map(&Map.put(&1, "learnset_id", learnset.id))
        |> Cards.create_cards(learnset.id)

        {:noreply,
         socket
         |> put_flash(:info, "Learnset updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_learnset(socket, :new, learnset_params) do
    case Learnsets.create_learnset(
           learnset_params
           |> Map.put("user_id", socket.assigns.current_user.id)
         ) do
      {:ok, learnset} ->
        learnset_params["cards"]
        |> Jason.decode!()
        |> Enum.map(&Map.put(&1, "learnset_id", learnset.id))
        |> Cards.create_cards(learnset.id)

        notify_parent({:saved, learnset})

        {:noreply,
         socket
         |> put_flash(:info, "Learnset created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
