defmodule LernmitWeb.TaskLive.Index do
  use LernmitWeb, :live_view

  alias Lernmit.Tasks
  alias Lernmit.Tasks.Task
  alias Lernmit.Auth.Policy
  alias Lernmit.Util.Message

  @impl true
  def mount(_params, _session, socket) do
    case Tasks.list_task(socket.assigns.current_user) do
      {:ok, tasks} ->
        {:ok,
         socket
         |> assign(:task_collection, tasks)
         |> assign(:page_title, "Tasks")
         |> assign(:current_user, socket.assigns.current_user)
         |> assign(:sort, "upcoming")}

      {:error, error} ->
        {:ok,
         socket
         |> put_flash(:error, Message.error(error))
         |> stream(:task_collection, [])}
    end
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    case Tasks.get_task!(socket.assigns.current_user, id) do
      {:ok, task} ->
        socket
        |> assign(:page_title, "Edit Task")
        |> assign(:task, task)
        |> assign(:current_user, socket.assigns.current_user)

      {:error, :not_found} ->
        socket
        |> put_flash(:error, "Task not found")
        |> push_navigate(to: "/task")
    end
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Task")
    |> assign(:task, %Task{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Tasks")
  end

  @impl true
  def handle_info({LernmitWeb.TaskLive.FormComponent, {:saved, task}}, socket) do
    {:noreply, stream_insert(socket, :task_collection, task)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    case Tasks.get_task!(socket.assigns.current_user, id) do
      {:ok, task} ->
        Tasks.delete_task(socket.assigns.current_user, task)

        {:noreply,
         socket
         |> assign(
           :task_collection,
           Enum.reject(socket.assigns.task_collection, &(&1.id == task.id))
         )}

      {:error, error} ->
        {:noreply,
         socket
         |> put_flash(:error, Message.error(error))
         |> push_navigate(to: "/task")}
    end
  end

  @impl true
  def handle_event("sort", %{"sort" => filter}, socket) do
    case sort_task(socket.assigns.current_user, filter) do
      {:ok, tasks} ->
        {:noreply,
         socket
         |> assign(:sort, filter)
         |> assign(:task_collection, tasks)}

      {:error, error} ->
        {:noreply,
         socket
         |> put_flash(:error, Message.error(error))}
    end
  end

  def sort_task(current_user, filter) do
    case filter do
      "upcoming" -> Tasks.filter_task(current_user, "TODO")
      "completed" -> Tasks.filter_task(current_user, "DONE")
      "past_due" -> Tasks.overdue_task(current_user)
    end
  end

  def sort_class(socket, option) do
    if @sort == option do
      "text-sky-500 dark:text-sky-400"
    else
      "text-black dark:text-white"
    end
  end
end
