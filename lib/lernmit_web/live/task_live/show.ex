defmodule LernmitWeb.TaskLive.Show do
  use LernmitWeb, :live_view

  alias Lernmit.Tasks
  alias Lernmit.Util.Message

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    case Tasks.get_task!(socket.assigns.current_user, id) do
      {:ok, task} ->
        {:noreply,
         socket
         |> assign(task: task)
         |> assign(:page_title, page_title(socket.assigns.live_action))}

      {:error, error} ->
        {:noreply,
         socket
         |> put_flash(:error, Message.error(error))
         |> push_navigate(to: "/task")}
    end
  end

  defp page_title(:show), do: "Show Task"
  defp page_title(:edit), do: "Edit Task"
end
