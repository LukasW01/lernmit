defmodule LernmitWeb.TaskLive.FormComponent do
  use LernmitWeb, :live_component

  alias Lernmit.Tasks
  alias Lernmit.Courses

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage task records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="task-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:title]} type="text" label="Title" />
        <.input field={@form[:text]} type="text" label="Text" />
        <.input field={@form[:status]} type="text" label="Status" />
        <.input field={@form[:types]} type="text" label="Types" />
        <.input field={@form[:due_date]} type="datetime-local" label="Due date" />
        <.input field={@form[:points]} type="number" label="Points" />
        <.input field={@form[:course_id]} type="select" label="Course" options={@courses} />
        <:actions>
          <.button phx-disable-with="Saving...">Save Task</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  def mount(_params, %{"current_user" => current_user} = _session, socket) do
    {:ok,
     socket
     |> assign(:current_user, current_user)
     |> assign(:title, "New Task")}
  end

  @impl true
  def update(%{task: task, current_user: current_user} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign(:current_user, current_user)
     |> assign(:courses, Enum.map(Courses.list_course_distinct(current_user), &{&1.name, &1.id}))
     |> assign_new(:form, fn ->
       to_form(Tasks.change_task(task))
     end)}
  end

  @impl true
  def handle_event("validate", %{"task" => task_params}, socket) do
    changeset = Tasks.change_task(socket.assigns.task, task_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"task" => task_params}, socket) do
    save_task(socket, socket.assigns.action, task_params)
  end

  defp save_task(socket, :edit, task_params) do
    case Tasks.update_task(socket.assigns.current_user, socket.assigns.task, task_params) do
      {:ok, task} ->
        notify_parent({:saved, task})

        {:noreply,
         socket
         |> put_flash(:info, "Task updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_task(socket, :new, task_params) do
    case Tasks.create_task(socket.assigns.current_user, task_params) do
      {:ok, task} ->
        notify_parent({:saved, task})

        {:noreply,
         socket
         |> put_flash(:info, "Task created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
