defmodule Lernmit.Tasks do
  @moduledoc """
  The Tasks context.
  """

  import Ecto.Query, warn: false
  alias Lernmit.Repo
  alias Lernmit.Users.User
  alias Lernmit.Tasks.Task
  alias Lernmit.Auth.Policy

  @doc """
  Returns the list of task.

  ## Examples

      iex> list_task()
      [%Task{}, ...]

  """
  def list_task(%User{} = current_user) do
    with :ok <- Policy.authorize(:task_read, current_user) do
      {:ok, Repo.all(from t in Task, where: t.user_id == ^current_user.id)}
    end
  end

  @doc """
  Returns the list of tasks for a given user.

  ## Examples

      iex> list_task_range(123, ~D[2024-10-17], ~D[2024-10-18])
      [%Task{}, ...]

      iex> list_task_range(456, ~D[2024-10-17], ~D[2024-10-18])
      ** (Ecto.NoResultsError)

  """
  def list_task_range(%User{} = current_user, start_date, end_date) do
    with :ok <- Policy.authorize(:task_read, current_user),
         {:ok, start_date_n} <- NaiveDateTime.from_iso8601("#{start_date} 00:00:00"),
         {:ok, end_date_n} <- NaiveDateTime.from_iso8601("#{end_date} 23:59:59") do
      Repo.all(
        from t in Task,
          where:
            t.user_id == ^current_user.id and
              t.due_date >= ^start_date_n and
              t.due_date <= ^end_date_n
      )
    end
  end

  @doc """
  Gets a single task.

  Raises `Ecto.NoResultsError` if the Task does not exist.

  ## Examples

      iex> get_task!(123)
      %Task{}

      iex> get_task!(456)
      ** (Ecto.NoResultsError)

  """
  def get_task!(%User{} = current_user, id) do
    with :ok <- Policy.authorize(:task_read, current_user) do
      case Repo.get_by(Task, id: id, user_id: current_user.id) do
        nil -> {:error, :not_found}
        task -> {:ok, task}
      end
    end
  end

  @doc """
  Creates a task.

  ## Examples

      iex> create_task(%{field: value})
      {:ok, %Task{}}

      iex> create_task(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_task(current_user, attrs \\ %{}) do
    with :ok <- Policy.authorize(:task_create, current_user) do
      %Task{}
      |> Task.changeset(attrs)
      |> Repo.insert()
    end
  end

  @doc """
  Updates a task.

  ## Examples

      iex> update_task(task, %{field: new_value})
      {:ok, %Task{}}

      iex> update_task(task, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_task(%User{} = current_user, %Task{} = task, attrs) do
    with :ok <- Policy.authorize(:task_update, current_user) do
      task
      |> Task.changeset(attrs)
      |> Repo.update()
    end
  end

  @doc """
  Deletes a task.

  ## Examples

      iex> delete_task(task)
      {:ok, %Task{}}

      iex> delete_task(task)
      {:error, %Ecto.Changeset{}}

  """
  def delete_task(%User{} = current_user, %Task{} = task) do
    with :ok <- Policy.authorize(:task_delete, current_user) do
      Repo.delete(task)
    end
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking task changes.

  ## Examples

      iex> change_task(task)
      %Ecto.Changeset{data: %Task{}}

  """
  def change_task(%Task{} = task, attrs \\ %{}) do
    Task.changeset(task, attrs)
  end
end
