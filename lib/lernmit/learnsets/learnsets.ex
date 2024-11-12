defmodule Lernmit.Learnsets do
  @moduledoc """
  The Learnsets context.
  """

  import Ecto.Query, warn: false
  alias Lernmit.Repo

  alias Lernmit.Learnsets.Learnset
  alias Lernmit.Users.User

  @doc """
  Returns the list of learnset.

  ## Examples

      iex> list_learnset()
      [%Learnset{}, ...]

  """
  def list_learnset do
    Repo.all(Learnset)
  end

  @doc """
  Gets a single learnset.

  Raises `Ecto.NoResultsError` if the Learnset does not exist.

  ## Examples

      iex> get_learnset!(123)
      %Learnset{}

      iex> get_learnset!(456)
      ** (Ecto.NoResultsError)

  """
  def get_learnset!(id) do
    case Repo.one(from l in Learnset, where: l.id == ^id) |> Repo.preload(:cards) do
      nil -> {:error, :not_found}
      learnset -> {:ok, learnset}
    end
  end

  @doc """
  Creates a learnset.

  ## Examples

      iex> create_learnset(%{field: value})
      {:ok, %Learnset{}}

      iex> create_learnset(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_learnset(attrs \\ %{}) do
    %Learnset{}
    |> Learnset.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a learnset.

  ## Examples

      iex> update_learnset(learnset, %{field: new_value})
      {:ok, %Learnset{}}

      iex> update_learnset(learnset, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_learnset(%User{} = current_user, %Learnset{} = learnset, attrs) do
    case learnset.user_id == current_user.id do
      true ->
        learnset
        |> Learnset.changeset(attrs)
        |> Repo.update()

      false ->
        {:error, :unauthorized}
    end
  end

  @doc """
  Deletes a learnset.

  ## Examples

      iex> delete_learnset(learnset)
      {:ok, %Learnset{}}

      iex> delete_learnset(learnset)
      {:error, %Ecto.Changeset{}}

  """
  def delete_learnset(%User{} = current_user, %Learnset{} = learnset) do
    case learnset.user_id == current_user.id do
      true -> Repo.delete(learnset)
      false -> {:error, :unauthorized}
    end
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking learnset changes.

  ## Examples

      iex> change_learnset(learnset)
      %Ecto.Changeset{data: %Learnset{}}

  """
  def change_learnset(%Learnset{} = learnset, attrs \\ %{}) do
    Learnset.changeset(learnset, attrs)
  end
end
