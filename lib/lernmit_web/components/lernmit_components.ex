defmodule LernmitWeb.LernmitComponents do
  @moduledoc """
  Provides universal components.
  """
  use LernmitWeb, :live_component
  use Phoenix.Component

  @doc """
  Renders a events section.
  """
  attr :calendar, :list, required: true

  def events(assigns) do
    ~H"""
    <section class="mt-12">
      <h2 class="text-base font-semibold leading-6 text-gray-900 dark:text-white">
        <%= gettext("upcoming_exams") %>
      </h2>
      <ol class="mt-2 divide-y divide-gray-200 dark:divide-gray-700 text-sm leading-6 text-gray-500 dark:text-gray-400">
        <%= if Enum.empty?(@calendar) do %>
          <li class="py-4 sm:flex">
            <p class="mt-2 flex-auto sm:mt-0">
              <%= gettext("empty_schedule") %>
            </p>
          </li>
        <% end %>
        <%= for task <- @calendar do %>
          <li class="py-4 sm:flex">
            <time datetime={Calendar.strftime(task.due_date, "%Y-%m-%d")} class="w-28 flex-none">
              <%= Calendar.strftime(task.due_date, "%B %d") %>
            </time>
            <.link patch={~p"/task/#{task.id}"}>
              <p class="mt-2 flex-auto font-semibold text-gray-900 dark:text-white sm:mt-0 hover:text-sky-500 dark:hover:text-sky-400">
                <%= task.title %>
              </p>
            </.link>
            <span class="ml-auto flex-none md:block hidden">
              <time datetime={Calendar.strftime(task.due_date, "%Y-%m-%d")}>
                <%= Calendar.strftime(task.due_date, "%I:%M %p") %>
              </time>
            </span>
          </li>
        <% end %>
      </ol>
    </section>
    """
  end

  def card(assigns) do
    ~H"""
    <div class="py-6 sm:py-8">
      <h2 class="text-md font-bold">Cards</h2>
      <ul class="space-y-6" phx-update="ignore" id="cards">
        <template x-for="(card, index) in cards" x-bind:key="index">
          <li class="p-4 border rounded-lg shadow space-y-4 dark:border-gray-700 dark:shadow-gray-800">
            <div
              class="form-group flex-grow-1 mb-0"
              x-data="{ required: false }"
              @error="required = $valid($event.detail, 'required')"
            >
              <label
                x-bind:for="'term_' + index"
                class="block text-sm font-medium leading-6 text-gray-900 dark:text-white pb-1"
              >
                Term
              </label>
              <input
                type="text"
                x-bind:id="'term_' + index"
                x-model="card.term"
                x-validation.required="card.term"
                placeholder="Add term"
                class="block w-full rounded-md border-0 py-1.5 bg-white dark:bg-gray-800 text-gray-900 dark:text-gray-100 shadow-sm ring-1 ring-inset ring-gray-300 dark:ring-gray-600 placeholder:text-gray-400 dark:placeholder:text-gray-500 focus:ring-2 focus:ring-inset focus:ring-indigo-600 dark:focus:ring-indigo-400"
              />
              <small
                x-cloak
                x-show="required"
                class="mt-1 flex gap-3 text-sm leading-6 text-rose-600 dark:text-rose-500"
              >
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
                class="block text-sm font-medium leading-6 text-gray-900 dark:text-white pb-1"
              >
                Definition
              </label>
              <textarea
                x-bind:id="'definition_' + index"
                x-model="card.definition"
                x-validation.required="card.definition"
                placeholder="Add definition"
                class="block w-full rounded-md border-0 bg-white dark:bg-gray-800 text-gray-900 dark:text-gray-100 shadow-sm ring-1 ring-inset ring-gray-300 dark:ring-gray-600 placeholder:text-gray-400 dark:placeholder:text-gray-500 focus:ring-2 focus:ring-inset focus:ring-indigo-600 dark:focus:ring-indigo-400 sm:text-sm/6 border-zinc-300 dark:border-gray-600 focus:border-zinc-400 dark:focus:border-gray-500"
                rows="3"
              ></textarea>
              <small
                x-cloak
                x-show="required"
                class="mt-1 flex gap-3 text-sm leading-6 text-rose-600 dark:text-rose-500"
              >
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
    """
  end
end
