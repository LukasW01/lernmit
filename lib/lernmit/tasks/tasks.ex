defmodule Lernmit.Tasks do
  @moduledoc """
  The Tasks context.
  """

  import Ecto.Query, warn: false
  alias Lernmit.Repo

  alias Lernmit.Tasks.Task

  @doc """
  Returns the list of task.

  ## Examples

      iex> list_task()
      [%Task{}, ...]

  """
  def list_task do
    Repo.all(Task)
  end

  @doc """
  Returns the list of tasks for a given user.

  ## Examples

      iex> list_task(123)
      [%Task{}, ...]

      iex> list_task(456)
      ** (Ecto.NoResultsError)

  """
  def list_task(user_id) do
    Repo.all(from t in Task, where: t.user_id == ^user_id)
  end

  @doc """
  Returns the list of tasks for a given user.

  ## Examples

      iex> list_task_range(123, ~D[2024-10-17], ~D[2024-10-18])
      [%Task{}, ...]

      iex> list_task_range(456, ~D[2024-10-17], ~D[2024-10-18])
      ** (Ecto.NoResultsError)

  """
  def list_task_range(user_id, start_date, end_date) do
    {:ok, start_date_naive} = NaiveDateTime.from_iso8601("#{start_date} 00:00:00")
    {:ok, end_date_naive} = NaiveDateTime.from_iso8601("#{end_date} 23:59:59")

    Repo.all(
      from t in Task,
        where:
          t.user_id == ^user_id and
            t.due_date >= ^start_date_naive and
            t.due_date <= ^end_date_naive
    )
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
  def get_task!(id), do: Repo.get!(Task, id)

  @doc """
  Creates a task.

  ## Examples

      iex> create_task(%{field: value})
      {:ok, %Task{}}

      iex> create_task(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_task(attrs \\ %{}) do
    %Task{}
    |> Task.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a task.

  ## Examples

      iex> update_task(task, %{field: new_value})
      {:ok, %Task{}}

      iex> update_task(task, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_task(%Task{} = task, attrs) do
    task
    |> Task.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a task.

  ## Examples

      iex> delete_task(task)
      {:ok, %Task{}}

      iex> delete_task(task)
      {:error, %Ecto.Changeset{}}

  """
  def delete_task(%Task{} = task) do
    Repo.delete(task)
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
