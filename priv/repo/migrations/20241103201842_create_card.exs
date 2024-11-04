defmodule Lernmit.Repo.Migrations.CreateCard do
  use Ecto.Migration

  def change do
    create table(:card) do
      add :term, :string
      add :definition, :text
      add :learnset_id, references(:learnset, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:card, [:learnset_id])
  end
end
