defmodule Lernmit.Achievements.Users do
  @moduledoc """
  The Achievements.Users context.
  """

  import Ecto.Query, warn: false
  alias Lernmit.Repo

  alias Lernmit.Achievements.Users.AchievementUsers

  @doc """
  Returns the list of achievement_users.

  ## Examples

      iex> list_achievement_users()
      [%AchievementUsers{}, ...]

  """
  def list_achievement_users do
    Repo.all(AchievementUsers)
  end

  @doc """
  Returns the list of achievement_users for a given user.

  ## Examples

      iex> list_achievement_users(123)
      [%AchievementUsers{}, ...]
  """
  def list_achievement_users(user_id) do
    Repo.all(from au in AchievementUsers, where: au.user_id == ^user_id)
  end

  @doc """
  Gets a single achievement_users.

  Raises `Ecto.NoResultsError` if the Achievement users does not exist.

  ## Examples

      iex> get_achievement_users!(123)
      %AchievementUsers{}

      iex> get_achievement_users!(456)
      ** (Ecto.NoResultsError)

  """
  def get_achievement_users!(id), do: Repo.get!(AchievementUsers, id)

  @doc """
  Creates a achievement_users.

  ## Examples

      iex> create_achievement_users(%{field: value})
      {:ok, %AchievementUsers{}}

      iex> create_achievement_users(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_achievement_users(attrs \\ %{}) do
    %AchievementUsers{}
    |> AchievementUsers.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a achievement_users.

  ## Examples

      iex> update_achievement_users(achievement_users, %{field: new_value})
      {:ok, %AchievementUsers{}}

      iex> update_achievement_users(achievement_users, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_achievement_users(%AchievementUsers{} = achievement_users, attrs) do
    achievement_users
    |> AchievementUsers.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a achievement_users.

  ## Examples

      iex> delete_achievement_users(achievement_users)
      {:ok, %AchievementUsers{}}

      iex> delete_achievement_users(achievement_users)
      {:error, %Ecto.Changeset{}}

  """
  def delete_achievement_users(%AchievementUsers{} = achievement_users) do
    Repo.delete(achievement_users)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking achievement_users changes.

  ## Examples

      iex> change_achievement_users(achievement_users)
      %Ecto.Changeset{data: %AchievementUsers{}}

  """
  def change_achievement_users(%AchievementUsers{} = achievement_users, attrs \\ %{}) do
    AchievementUsers.changeset(achievement_users, attrs)
  end
end
