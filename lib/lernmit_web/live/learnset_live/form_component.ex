defmodule LernmitWeb.LearnsetLive.FormComponent do
  use LernmitWeb, :live_component

  alias Lernmit.Learnsets
  alias Lernmit.Cards
  alias Lernmit.Cards.Card
  import LernmitWeb.LernmitComponents

  @impl true
  def render(assigns) do
    ~H"""
    <div x-data="{ cards: [{ term: '', definition: '' }] }">
      <.header>
        <%= @title %>
      </.header>

      <.simple_form for={@form} id="learnset-form" phx-target={@myself} phx-submit="save">
        <.input field={@form[:title]} type="text" label="Title" />
        <.input field={@form[:desc]} type="textarea" label="Desc" />
        <input type="hidden" name="learnset[cards]" x-model="JSON.stringify(cards)" />
        <div class="py-6 sm:py-8">
          <h2 class="mb-4 text-2xl font-bold text-gray-900 dark:text-white">Cards</h2>
          <ul class="space-y-6">
            <template x-for="(card, index) in cards" x-bind:key="index">
              <li class="p-4 border rounded-lg shadow space-y-4 dark:border-gray-700 dark:shadow-gray-800">
                <div
                  class="form-group flex-grow-1 mb-0"
                  x-data="{ required: false }"
                  @error="required = $valid($event.detail, 'required')"
                >
                  <label
                    x-bind:for="'term_' + index"
                    class="block text-sm font-medium leading-6 text-gray-900 dark:text-white"
                  >
                    Term
                  </label>
                  <input
                    type="text"
                    x-bind:id="'term_' + index"
                    x-model="card.term"
                    x-validation.required="card.term"
                    placeholder="Add term"
                    class="block w-full mt-1 text-gray-900 dark:text-white dark:bg-gray-700 border-transparent rounded-md focus:border-gray-500 dark:focus:border-gray-400 focus:bg-white dark:focus:bg-gray-700 focus:ring-0"
                  />
                  <small x-cloak x-show="required" class="text-red-600 mt-1 block">
                    Term is required
                  </small>
                </div>
                <div
                  class="form-group flex-grow-1 mb-0 mt-4"
                  x-data="{ required: false }"
                  @error="required = $valid($event.detail, 'required')"
                >
                  <label
                    x-bind:for="'definition_' + index"
                    class="block text-sm font-medium leading-6 text-gray-900 dark:text-white"
                  >
                    Definition
                  </label>
                  <textarea
                    x-bind:id="'definition_' + index"
                    x-model="card.definition"
                    x-validation.required="card.definition"
                    placeholder="Add definition"
                    class="block w-full mt-1 text-gray-900 dark:text-white dark:bg-gray-700 border-transparent rounded-md focus:border-gray-500 dark:focus:border-gray-400 focus:bg-white dark:focus:bg-gray-700 focus:ring-0"
                    rows="3"
                  ></textarea>
                  <small x-cloak x-show="required" class="text-red-600 mt-1 block">
                    Definition is required
                  </small>
                </div>
                <button @click="cards.splice(index, 1)" type="button">
                  <svg
                    class="w-6 h-6 text-gray-900 dark:text-white"
                    fill="none"
                    stroke="currentColor"
                    viewBox="0 0 24 24"
                    xmlns="http://www.w3.org/2000/svg"
                  >
                    <path
                      stroke-linecap="round"
                      stroke-linejoin="round"
                      stroke-width="2"
                      d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"
                    >
                    </path>
                  </svg>
                </button>
              </li>
            </template>
          </ul>
          <div class="flex justify-center mt-4">
            <button
              @click="cards.push({ term: '', definition: '' })"
              type="button"
              class="inline-flex items-center px-3 py-1.5 text-base font-semibold text-gray-900 dark:text-white bg-white dark:bg-gray-800 rounded-md border border-gray-900 dark:border-gray-700 focus:outline-none focus:ring-2 focus:ring-gray-500 dark:focus:ring-gray-400"
            >
              Add Card
            </button>
          </div>
        </div>
        <:actions>
          <div class="ml-auto mt-6 flex items-center justify-end gap-x-6">
            <.simple_button
              phx-click={JS.navigate(~p"/learnset")}
              class="text-sm/6 font-semibold text-gray-900 dark:text-white"
            >
              Cancel
            </.simple_button>
            <.button phx-disable-with="Saving...">Save</.button>
          </div>
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
        apply_action(socket, assigns, :edit, learnset)

      false ->
        if learnset.user_id == nil do
          apply_action(socket, assigns, :new, learnset)
        else
          {:error, :unauthorized}
        end
    end
  end

  def apply_action(socket, assigns, :new, learnset) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign(:cards, [%Card{id: 1, term: "", definition: ""}])
     |> assign_new(:form, fn ->
       to_form(Learnsets.change_learnset(learnset))
     end)}
  end

  def apply_action(socket, assigns, :edit, learnset) do
    case Cards.list_card(learnset.id) do
      cards ->
        {:ok,
         socket
         |> assign(assigns)
         |> assign(:cards, cards)
         |> assign_new(:form, fn ->
           to_form(Learnsets.change_learnset(learnset))
         end)}
    end
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
    case Learnsets.create_learnset(
           learnset_params
           |> Map.put("user_id", socket.assigns.current_user.id)
         ) do
      {:ok, learnset} ->
        learnset_params["cards"]
        |> Jason.decode!()
        |> Enum.map(&Map.put(&1, "learnset_id", learnset.id))
        |> Cards.create_cards()

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
