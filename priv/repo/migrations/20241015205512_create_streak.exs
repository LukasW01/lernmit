defmodule Lernmit.Repo.Migrations.CreateStreaks do
  use Ecto.Migration

  def change do
    create table(:streak) do
      add :user_id, references(:users, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:streak, [:user_id])
  end
end
