defmodule Lernmit.Achievements.Achievement do
  @moduledoc """
  Achievement schema.
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "achievement" do
    field :title, :string
    field :desc, :string
    field :image, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(achievement, attrs) do
    achievement
    |> cast(attrs, [:image, :title, :desc])
    |> validate_required([:image, :title, :desc])
    |> unique_constraint([:image, :title, :desc])
  end

  def admin_changeset(achievement, attrs, _metadata \\ []) do
    achievement
    |> cast(attrs, [:image, :title, :desc])
    |> validate_required([:image, :title, :desc])
    |> unique_constraint([:image, :title, :desc])
  end
end
