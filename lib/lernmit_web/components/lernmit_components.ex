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
      <h2 class="text-base font-semibold leading-6 text-gray-900 dark:text-white">Upcoming events</h2>
      <ol class="mt-2 divide-y divide-gray-200 dark:divide-gray-700 text-sm leading-6 text-gray-500 dark:text-gray-400">
        <%= if Enum.empty?(@calendar) do %>
          <li class="py-4 sm:flex">
            <p class="mt-2 flex-auto sm:mt-0">Nothing on your schedule.</p>
          </li>
        <% end %>
        <%= for task <- @calendar do %>
          <li class="py-4 sm:flex">
            <time datetime={Calendar.strftime(task.due_date, "%Y-%m-%d")} class="w-28 flex-none">
              <%= Calendar.strftime(task.due_date, "%B %d") %>
            </time>
            <.link patch={~p"/task/#{task.id}"}>
              <p class="mt-2 flex-auto font-semibold text-gray-900 dark:text-white sm:mt-0">
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
end
