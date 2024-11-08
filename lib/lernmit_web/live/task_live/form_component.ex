defmodule LernmitWeb.TaskLive.FormComponent do
  use LernmitWeb, :live_component

  alias Lernmit.Tasks
  alias Lernmit.Courses
  alias Lernmit.Auth.Policy

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
      </.header>

      <.simple_form
        for={@form}
        id="task-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:title]} type="text" label="Title" />
        <.input field={@form[:text]} type="textarea" label="Text" />
        <.input
          field={@form[:types]}
          type="select"
          label="Types"
          options={[{"Exam", "EXAM"}, {"Exercise", "EXERCISE"}]}
          phx-change="exam_selected"
          phx-value-types={@exam}
        />
        <.input field={@form[:due_date]} type="datetime-local" label="Due date" />
        <.input :if={@exam} field={@form[:points]} type="number" label="Points" />
        <.input field={@form[:course_id]} type="select" label="Course" options={@courses} />
        <:actions>
          <div class="ml-auto mt-6 flex items-center justify-end gap-x-6">
            <.simple_button
              phx-click={JS.navigate(~p"/task")}
              class="text-sm/6 font-semibold text-gray-900"
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
     |> assign(:title, "New Task")}
  end

  @impl true
  def update(%{task: task, current_user: current_user} = assigns, socket) do
    if Policy.authorize(:task_create, current_user) == :ok and task.user_id == current_user.id do
      {:ok, apply_action(socket, assigns, task)}
    else
      {:error, :unauthorized}
    end
  end

  defp apply_action(socket, assigns, task) do
    socket
    |> assign(assigns)
    |> assign(:exam, task_types(task.types))
    |> assign(
      :courses,
      Enum.map(
        Courses.list_course_distinct(socket.assigns.current_user),
        &{"#{&1.class} (#{&1.subject})", &1.id}
      )
    )
    |> assign_new(:form, fn ->
      to_form(Tasks.change_task(task))
    end)
  end

  @impl true
  def handle_event("validate", %{"task" => task_params}, socket) do
    changeset = Tasks.change_task(socket.assigns.task, task_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"task" => task_params}, socket) do
    save_task(socket, socket.assigns.action, task_params)
  end

  def handle_event("exam_selected", %{"task" => %{"types" => types}}, socket) do
    {:noreply, assign(socket, exam: task_types(types))}
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

  defp task_types(task) do
    case task do
      "EXAM" -> true
      "EXERCISE" -> false
      _ -> true
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
