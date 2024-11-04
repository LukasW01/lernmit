defmodule Lernmit.Repo.Migrations.CreateLearnset do
  use Ecto.Migration

  def change do
    create table(:learnset) do
      add :title, :string
      add :desc, :text
      add :user_id, references(:users, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:learnset, [:user_id])
  end
end
