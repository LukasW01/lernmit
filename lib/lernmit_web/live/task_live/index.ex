defmodule LernmitWeb.TaskLive.Index do
  use LernmitWeb, :live_view

  alias Lernmit.Tasks
  alias Lernmit.Tasks.Task
  alias Lernmit.Auth.Policy

  @impl true
  def mount(_params, _session, socket) do
    case Tasks.list_task(socket.assigns.current_user) do
      {:ok, tasks} ->
        {:ok,
         socket
         |> stream(:task_collection, tasks)
         |> assign(:current_user, socket.assigns.current_user)}
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
    |> assign(:task, nil)
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

        {:noreply, stream_delete(socket, :task_collection, task)}

      {:error, :not_found} ->
        {:noreply,
         socket
         |> put_flash(:error, "Task not found")
         |> push_navigate(to: "/task")}
    end
  end
end
