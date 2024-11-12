defmodule Lernmit.Cards do
  @moduledoc """
  The Cards context.
  """

  import Ecto.Query, warn: false
  alias Lernmit.Repo

  alias Lernmit.Cards.Card

  @doc """
  Returns the list of card.

  ## Examples

      iex> list_card()
      [%Card{}, ...]

  """
  def list_card(set_id) do
    Repo.all(
      Card
      |> where(learnset_id: ^set_id)
    )
  end

  def list_card do
    Repo.all(Card)
  end

  @doc """
  Gets a single card.

  Raises `Ecto.NoResultsError` if the Card does not exist.

  ## Examples

      iex> get_card!(123)
      %Card{}

      iex> get_card!(456)
      ** (Ecto.NoResultsError)

  """
  def get_card!(id), do: Repo.get!(Card, id)

  @doc """
  Creates a card.

  ## Examples

      iex> create_card(%{field: value})
      {:ok, %Card{}}

      iex> create_card(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_card(attrs \\ %{}) do
    %Card{}
    |> Card.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Creates a list of cards.  
    
  ## Examples

      iex> create_cards([%{field: value}, %{field: value}])
      [%Card{}, %Card{}]
  """
  def create_cards(cards \\ [], set_id) do
    delete_card(set_id)

    Enum.each(cards, fn card ->
      %Card{}
      |> Card.changeset(card)
      |> Repo.insert()
    end)
  end

  @doc """
  Updates a card.

  ## Examples

      iex> update_card(card, %{field: new_value})
      {:ok, %Card{}}

      iex> update_card(card, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_card(%Card{} = card, attrs) do
    card
    |> Card.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a card.

  ## Examples

      iex> delete_card(card)
      {:ok, %Card{}}

      iex> delete_card(card)
      {:error, %Ecto.Changeset{}}

  """
  def delete_card(%Card{} = card) do
    Repo.delete(card)
  end

  def delete_card(set_id) do
    Repo.delete_all(from(c in Card, where: c.learnset_id == ^set_id))
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking card changes.

  ## Examples

      iex> change_card(card)
      %Ecto.Changeset{data: %Card{}}

  """
  def change_card(%Card{} = card, attrs \\ %{}) do
    Card.changeset(card, attrs)
  end
end
