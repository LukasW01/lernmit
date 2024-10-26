defmodule Lernmit.Classes.Class do
  @moduledoc """
  Class schema.
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "class" do
    field :name, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(class, attrs) do
    class
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
